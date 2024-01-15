import Flutter
import HealthKit
import UIKit

public class FlutterHealthKitPlugin: NSObject, FlutterPlugin {
    lazy var store: HKHealthStore = { HKHealthStore() }()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_health_kit", binaryMessenger: registrar.messenger())
    let instance = FlutterHealthKitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        return true
    }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "requestAuthorization":
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        let toShare = (arguments["toShare"] as? [String])?.map { $0.sampleType}.compactMap { $0 }
        let read = (arguments["read"] as? [String])?.map { $0.objectType}.compactMap { $0 }
        store.requestAuthorization(toShare: toShare?.toSet, read: read?.toSet) { value, error in
            if let error = error {
                result(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: error))
            } else {
                result(value)
            }
        }
    case "querySampleType":
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        guard let type = arguments["sampleType"] as? String, let sampleType = type.sampleType else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        let limit = arguments["limit"] as? Int ?? HKObjectQueryNoLimit
        let sortDescriptors = (arguments["sortDescriptors"] as? [Any])?.map { $0 as! [String: Any]}
            .map { v in NSSortDescriptor(
                key: v["key"] as? String,
                ascending: v["ascending"] as! Bool
            )}
        let query = HKSampleQuery(sampleType: sampleType, predicate: HKQuery.predicateForSamples(
            withStart: .distantPast,
            end: .distantFuture,
            options: []
        ), limit: limit, sortDescriptors: sortDescriptors) { (_, data, error) in
            guard
                error == nil,
                let results = data
            else {
                DispatchQueue.main.async {
                    result(FlutterError(code: "flutter_health_kit", message: error?.localizedDescription, details: error))
                }
                return
            }
            let workouts = results.map({ $0 as? HKWorkout}).compactMap({ $0 })
            if !workouts.isEmpty {
                DispatchQueue.main.async {
                    result(workouts.map { $0.toJson })
                }
                return
            }
            let quantities = results.map({ $0 as? HKQuantitySample}).compactMap({ $0 })
            if !quantities.isEmpty {
                let unitTypes = [sampleType].map( { $0 as? HKQuantityType}).compactMap({ $0 })
                self.store.preferredUnits(for: Set(unitTypes)) { types, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            result(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: error))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        result(quantities.map { $0.toJson(types) })
                    }
                }
                return
            }
            result([])
        }
        store.execute(query)
    case "enableBackgroundDelivery":
        guard let arguments = call.arguments as? [String: Any] else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        guard let type = arguments["type"] as? String, let objectType = type.objectType else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        let frequency = arguments["frequency"] as? Int ?? 1
        store.enableBackgroundDelivery(for: objectType, frequency: HKUpdateFrequency(rawValue: frequency) ?? HKUpdateFrequency.hourly) { value, error in
            if let error = error {
                result(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: error))
            } else {
                result(value)
            }
        }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

