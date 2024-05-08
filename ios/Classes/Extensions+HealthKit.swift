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
        } else if let data = metadata[key] as? HKQuantity {
            result[key] = data.toJson
        } else {
            debugPrint("ignored metadata: \(key) \(String(describing: metadata[key]))")
        }
    }
    guard !result.isEmpty else {
        return nil
    }
    return result
}

extension HKQuantity {
    static var allUnits: [HKUnit] = [
        HKUnit.percent(),
        HKUnit.meter(),
        HKUnit.degreeCelsius(),
        HKUnit.hertz(),
        HKUnit.atmosphere(),
        HKUnit.count(),
        HKUnit.minute(),
        HKUnit.gram(),
        HKUnit.volt(),
        HKUnit.count().unitDivided(by: HKUnit.minute()),
        HKUnit.kilocalorie().unitDivided(by: HKUnit.minute()),
        HKUnit.kilocalorie().unitDivided(by: HKUnit.hour().unitMultiplied(by: HKUnit.gramUnit(with: HKMetricPrefix.kilo))),
        HKUnit.watt(),
        HKUnit.kilocalorie()
    ]
    var toJson: [String: Double] {
        var values: [String: Double] = [:]
        for unit in HKQuantity.allUnits {
            if self.is(compatibleWith: unit) {
                values[unit.unitString] = doubleValue(for: unit)
            }
        }
        if values.isEmpty {
            debugPrint("failed to convert units: \(self)")
        }
        return values
    }
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

extension HKElectrocardiogram {
    var toJson : [String: Any] {
        return [
            "uuid": uuid.uuidString,
            "identifier": sampleType.identifier,
            "startTimestamp": startDate.timeIntervalSince1970,
            "endTimestamp": endDate.timeIntervalSince1970,
            "numberOfVoltageMeasurements": numberOfVoltageMeasurements,
            "samplingFrequency": samplingFrequency?.toJson,
            "classification": classification.rawValue,
            "averageHeartRate": averageHeartRate?.toJson,
            "symptomsStatus": symptomsStatus.rawValue,
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
