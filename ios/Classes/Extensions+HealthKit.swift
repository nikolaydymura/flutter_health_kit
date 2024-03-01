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
        } /*else if let data = metadata[key] as? HKQuantity {
#if DEBUG
            let distance = HKUnit.meterUnit(with: .centi)
            let percent = HKUnit.percent()
            let temp = HKUnit.degreeCelsius()
            let kkcal = HKUnit.internationalUnit()
            if data.is(compatibleWith: distance) {
                result[key] = [distance.unitString: data.doubleValue(for: distance)]
            } else if data.is(compatibleWith: percent) {
                result[key] = [percent.unitString: data.doubleValue(for: percent)]
            } else if data.is(compatibleWith: temp) {
                result[key] = [temp.unitString: data.doubleValue(for: temp)]
            } else {
                print(data)
            }
            print("ignored metadata: \(key) \(String(describing: metadata[key]))")
#endif
        }*/ else {
            debugPrint("ignored metadata: \(key) \(String(describing: metadata[key]))")
        }
    }
    guard !result.isEmpty else {
        return nil
    }
    return result
}

extension HKQuantitySample {
    func toJson(_ units: [HKQuantityType : HKUnit]) -> [String: Any] {
        var values: [String: Double] = [:]
        if let type = sampleType as? HKQuantityType, let unit = units[type] {
            values[unit.unitString] = quantity.doubleValue(for: unit)
        }
        return [
            "uuid": uuid.uuidString,
            "identifier": sampleType.identifier,
            "startTimestamp": startDate.timeIntervalSince1970,
            "endTimestamp": endDate.timeIntervalSince1970,
            "quantityType": quantityType.identifier,
            "count": count,
            "values": values,
            "device": device?.toJson,
            "sourceRevision": sourceRevision.toJson,
            "metadata": metadataToJson(metadata),
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
            "metadata": metadataToJson(metadata),
        ].compactMapValues { $0 }
    }
}

extension HKCorrelation {
    func toJson(_ units: [HKQuantityType : HKUnit]) -> [String: Any] {
        return [
            "uuid": uuid.uuidString,
            "identifier": sampleType.identifier,
            "startTimestamp": startDate.timeIntervalSince1970,
            "endTimestamp": endDate.timeIntervalSince1970,
            "correlationType": correlationType.identifier,
            "objects": objects.map {$0 as? HKQuantitySample }
                .compactMap { $0 }
                .map { $0.toJson(units)},
            "device": device?.toJson,
            "sourceRevision": sourceRevision.toJson,
            "metadata": metadataToJson(metadata),
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
