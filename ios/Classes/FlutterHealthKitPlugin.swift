import Flutter
import HealthKit
import UIKit

public class FlutterHealthKitPlugin: NSObject, FlutterPlugin {
    let binaryMessenger: FlutterBinaryMessenger
    lazy var store: HKHealthStore = { HKHealthStore() }()
    var longRunningQueries: [HKObserverQueryHandler] = []
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_health_kit", binaryMessenger: registrar.messenger())
    let instance = FlutterHealthKitPlugin(binaryMessenger: registrar.messenger())
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
        let predicate = arguments["predicate"] as? [String: Any]
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate?.predicate, limit: limit, sortDescriptors: sortDescriptors) { (_, data, error) in
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
    case "observeQuery":
        guard let arguments = call.arguments as? String, let sampleType = arguments.sampleType else {
            result(FlutterError(code: "flutter_health_kit", message: "\(call.method) invalid arguments \(String(describing: call.arguments))", details: nil))
            return
        }
        let handler = HKObserverQueryHandler(store: store, sampleType: sampleType)
        
        longRunningQueries.append(handler)
        result("flutter_health_kit_query_\(handler.id)")
        FlutterEventChannel(name: "flutter_health_kit_query_\(handler.id)", binaryMessenger: binaryMessenger).setStreamHandler(handler)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

class HKObserverQueryHandler: NSObject, FlutterStreamHandler {
    let store: HKHealthStore
    let sampleType: HKSampleType
    var query: HKObserverQuery?
    
    init(store: HKHealthStore, sampleType: HKSampleType) {
        self.store = store
        self.sampleType = sampleType
    }
    
    var id: String {
        sampleType.identifier
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        guard let arguments = arguments as? [String: Any] else {
            return FlutterError(code: "flutter_health_kit", message: "invalid arguments \(String(describing: arguments))", details: nil)
        }
        let start = arguments["startDate"] as! Int
        let end = arguments["endDate"] as! Int
        
        let query = HKObserverQuery(sampleType: sampleType,
                                    predicate: HKObserverQuery.predicateForSamples(withStart: Date(timeIntervalSince1970: TimeInterval(start)), end: Date(timeIntervalSince1970: TimeInterval(end)))) {query, handler, error in
            if let error = error {
                DispatchQueue.main.async {
                    events(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: error))
                }
            } else if let identifier = query.objectType?.identifier {
                DispatchQueue.main.async {
                    events(identifier)
                }
            }
            handler()
        }
        
        store.execute(query)
        self.query = query
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        if let query = self.query {
            store.stop(query)
            self.query = nil
        }
        return nil
    }
    
}
