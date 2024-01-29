import Flutter
import HealthKit
import UIKit
import os

public class FlutterHealthKitPlugin: NSObject, FlutterPlugin {
    let binaryMessenger: FlutterBinaryMessenger
    lazy var store: HKHealthStore = { HKHealthStore() }()
    
    fileprivate static var logger: Logger = {
        return Logger(subsystem: Bundle.main.bundleIdentifier!, category: "flutter_health_kit")
    }()
    
    var longRunningQueries: [HKSampleType: HKObserverQueryHandler] = [:]
    
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
        let settings = UserDefaults.standard
        if let items = settings.value(forKey: "BackgroundDeliveryItems") as? [String] {
            Task.init {
                try? await restoreQueries(items: items)
            }
        }
        return true
    }
    
    func restoreQueries(items: [String]) async throws {
        let read = items.map { $0.sampleType}.compactMap { $0 }
        try await store.requestAuthorization(toShare: Set(), read: read.toSet)
        try await store.disableAllBackgroundDelivery()
        for item in read {
            let handler = HKObserverQueryHandler(store: store, sampleType: item)
            longRunningQueries[item] = handler
            handler.start()
            try await store.enableBackgroundDelivery(for: item, frequency: .immediate)
        }
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
                    result(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: nil))
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
                        result(FlutterError(code: "flutter_health_kit", message: error?.localizedDescription, details: nil))
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
                DispatchQueue.main.async {
                    result([])
                }
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
            
            let settings = UserDefaults.standard
            var items: [String] = settings.value(forKey: "BackgroundDeliveryItems") as? [String] ?? []
            if !items.contains(type) {
                items.append(type)
                settings.setValue(items, forKey: "BackgroundDeliveryItems")
                settings.synchronize()
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
            let handler = longRunningQueries[sampleType] ?? HKObserverQueryHandler(store: store, sampleType: sampleType)
            
            longRunningQueries[sampleType] = handler
            result("flutter_health_kit_query_\(sampleType.identifier)")
            FlutterEventChannel(name: "flutter_health_kit_query_\(sampleType.identifier)", binaryMessenger: binaryMessenger).setStreamHandler(handler)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

class HKObserverQueryHandler: NSObject, FlutterStreamHandler {
    let store: HKHealthStore
    let sampleType: HKSampleType
    var query: HKObserverQuery?
    var eventSink: FlutterEventSink?
    var items: [HKObjectType] = []
    
    init(store: HKHealthStore, sampleType: HKSampleType) {
        self.store = store
        self.sampleType = sampleType
    }
    
    var id: String {
        sampleType.identifier
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        for item in items {
            events(item.identifier)
        }
        items.removeAll()
        start()
        return nil
    }
    
    public func start() {
        if query == nil {
            let query = HKObserverQuery(sampleType: sampleType, predicate: nil){query, handler, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.eventSink?(FlutterError(code: "flutter_health_kit", message: error.localizedDescription, details: nil))
                    }
                } else if let objectType = query.objectType {
                    DispatchQueue.main.async {
                        if let sink = self.eventSink  {
                            if !self.items.isEmpty {
                                for item in self.items {
                                    sink(item.identifier)
                                }
                                self.items.removeAll()
                            }
                            sink(objectType.identifier)
                        } else {
                            self.items.append(objectType)
                        }
                    }
                }
                handler()
            }
            
            store.execute(query)
            self.query = query
        }
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        if let query = self.query {
            store.stop(query)
            self.query = nil
        }
        eventSink = nil
        items.removeAll()
        return nil
    }
    
}
