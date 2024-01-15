import HealthKit

private func metadataToJson(_ metadata: [String: Any]?) -> [String: Any]? {
    guard let metadata = metadata else {
        return nil
    }
    var result: [String: Any] = [:]
    for key in metadata.keys {
        if metadata[key] is String {
            result[key] = metadata[key]
        } else if metadata[key] is Int {
            result[key] = metadata[key]
        } else if metadata[key] is Double {
            result[key] = metadata[key]
        }
    }
    guard !result.isEmpty else {
        return nil
    }
    return result
}

extension HKQuantitySample {
    func toJson(_ units: [HKQuantityType : HKUnit]) -> [String: Any] {
        return [
            "uuid": uuid.uuidString,
            "identifier": sampleType.identifier,
            "startTimestamp": startDate.timeIntervalSince1970,
            "endTimestamp": endDate.timeIntervalSince1970,
            "quantityType": quantityType.identifier,
            "count": count,
            "values": units.map( { ($0.value.unitString, quantity.doubleValue(for: $0.value))}),
            "device": device?.toJson,
            "sourceRevision": sourceRevision.toJson,
            "metadate": metadataToJson(metadata),
        ].compactMapValues { $0 }
    }
}

extension HKWorkout {
    var toJson: [String: Any] {
        return [
            "uuid": uuid.uuidString,
            "identifier": sampleType.identifier,
            "startTimestamp": startDate.timeIntervalSince1970,
            "endTimestamp": endDate.timeIntervalSince1970,
            "workoutActivityType": workoutActivityType.rawValue,
            "device": device?.toJson,
            "sourceRevision": sourceRevision.toJson,
            "duration": duration,
            "workoutEvents": [],
            "metadate": metadataToJson(metadata),
        ].compactMapValues { $0 }
    }
}

extension HKDevice {
    var toJson: [String: Any] {
        return [
            "udiDeviceIdentifier": udiDeviceIdentifier,
            "firmwareVersion": firmwareVersion,
            "hardwareVersion": hardwareVersion,
            "localIdentifier": localIdentifier,
            "manufacturer": manufacturer,
            "model": model,
            "name": name,
            "softwareVersion": softwareVersion,
        ].compactMapValues { $0 }
    }
}

extension HKSourceRevision {
    var toJson: [String: Any] {
        return [
            "productType": productType,
            "version": version,
            "source": [
                "name" : source.name,
                "bundleIdentifier" : source.bundleIdentifier,
            ],
            "operatingSystemVersion" : [
                "minorVersion" : operatingSystemVersion.minorVersion,
                "majorVersion" : operatingSystemVersion.majorVersion,
                "patchVersion" : operatingSystemVersion.patchVersion,
            ]
        ].compactMapValues { $0 }
    }
}
