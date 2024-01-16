import HealthKit

extension [String: Any] {
    var predicate: NSPredicate? {
        guard let code = self["code"] as? String else {
            return nil
        }
        if code == "predicateForSamples" {
            guard let start = self["withStart"] as? Double else {
                return nil
            }
            guard let end = self["end"] as? Double else {
                return nil
            }
            let startDate = Date(timeIntervalSince1970: TimeInterval(start))
            let endDate = Date(timeIntervalSince1970: TimeInterval(end))
            let strictStartDate = self["strictStartDate"] as? Bool
            let strictEndDate = self["strictEndDate"] as? Bool
            var options: HKQueryOptions = []
            if strictStartDate == true {
                options = HKQueryOptions.strictStartDate
            }
            if strictEndDate == true {
                options = HKQueryOptions.strictEndDate
            }
            return HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: options
            )
        }
        return nil
    }
}
extension [HKSampleType] {
    var toSet: Set<HKSampleType> {
        Set(self)
    }
}
extension [HKObjectType] {
    var toSet: Set<HKObjectType> {
        Set(self)
    }
}
extension String {
    var sampleType: HKSampleType? {
        if (HKSampleType.workoutType().identifier == self){
            return HKSampleType.workoutType()
        }
        if (HKSampleType.electrocardiogramType().identifier == self){
            return HKSampleType.electrocardiogramType()
        }
        if (HKSampleType.audiogramSampleType().identifier == self){
            return HKSampleType.audiogramSampleType()
        }
        if (HKSampleType.visionPrescriptionType().identifier == self){
            return HKSampleType.visionPrescriptionType()
        }
        if (HKSeriesType.workoutRoute().identifier == self){
            return HKSeriesType.workoutRoute()
        }
        if (HKSeriesType.heartbeat().identifier == self){
            return HKSeriesType.heartbeat()
        }
        if let type = documentTypeIdentifier {
            return HKSampleType.documentType(forIdentifier: type)
        }
        if let type = categoryTypeIdentifier {
            return HKSampleType.categoryType(forIdentifier: type)
        }
        if let type = clinicalTypeIdentifier {
            return HKSampleType.clinicalType(forIdentifier: type)
        }
        if let type = correlationTypeIdentifier {
            return HKSampleType.correlationType(forIdentifier: type)
        }
        if let type = quantityTypeIdentifier {
            return HKSampleType.quantityType(forIdentifier: type)
        }
        debugPrint("Unknown HKSampleType for \(self)")
        return nil
    }
    
    var objectType: HKObjectType? {
        if (HKSampleType.activitySummaryType().identifier == self){
            return HKSampleType.activitySummaryType()
        }
        let value = sampleType
        if value == nil {
            debugPrint("Unknown HKObjectType for \(self)")
        }
        return value
    }
}
extension String {
    var quantityTypeIdentifier: HKQuantityTypeIdentifier? {
        if (HKQuantityTypeIdentifier.appleSleepingWristTemperature.rawValue == self){
            return HKQuantityTypeIdentifier.appleSleepingWristTemperature
        }
        if (HKQuantityTypeIdentifier.bodyFatPercentage.rawValue == self){
            return HKQuantityTypeIdentifier.bodyFatPercentage
        }
        if (HKQuantityTypeIdentifier.bodyMass.rawValue == self){
            return HKQuantityTypeIdentifier.bodyMass
        }
        if (HKQuantityTypeIdentifier.bodyMassIndex.rawValue == self){
            return HKQuantityTypeIdentifier.bodyMassIndex
        }
        if (HKQuantityTypeIdentifier.electrodermalActivity.rawValue == self){
            return HKQuantityTypeIdentifier.electrodermalActivity
        }
        if (HKQuantityTypeIdentifier.height.rawValue == self){
            return HKQuantityTypeIdentifier.height
        }
        if (HKQuantityTypeIdentifier.leanBodyMass.rawValue == self){
            return HKQuantityTypeIdentifier.leanBodyMass
        }
        if (HKQuantityTypeIdentifier.waistCircumference.rawValue == self){
            return HKQuantityTypeIdentifier.waistCircumference
        }
        if (HKQuantityTypeIdentifier.activeEnergyBurned.rawValue == self){
            return HKQuantityTypeIdentifier.activeEnergyBurned
        }
        if (HKQuantityTypeIdentifier.appleExerciseTime.rawValue == self){
            return HKQuantityTypeIdentifier.appleExerciseTime
        }
        if (HKQuantityTypeIdentifier.appleMoveTime.rawValue == self){
            return HKQuantityTypeIdentifier.appleMoveTime
        }
        if (HKQuantityTypeIdentifier.appleStandTime.rawValue == self){
            return HKQuantityTypeIdentifier.appleStandTime
        }
        if (HKQuantityTypeIdentifier.basalEnergyBurned.rawValue == self){
            return HKQuantityTypeIdentifier.basalEnergyBurned
        }
        if #available(iOS 17.0, *) {
            if (HKQuantityTypeIdentifier.cyclingCadence.rawValue == self){
                return HKQuantityTypeIdentifier.cyclingCadence
            }
            if (HKQuantityTypeIdentifier.cyclingFunctionalThresholdPower.rawValue == self){
                return HKQuantityTypeIdentifier.cyclingFunctionalThresholdPower
            }
            if (HKQuantityTypeIdentifier.cyclingPower.rawValue == self){
                return HKQuantityTypeIdentifier.cyclingPower
            }
            if (HKQuantityTypeIdentifier.cyclingSpeed.rawValue == self){
                return HKQuantityTypeIdentifier.cyclingSpeed
            }
        }
        if (HKQuantityTypeIdentifier.distanceCycling.rawValue == self){
            return HKQuantityTypeIdentifier.distanceCycling
        }
        if (HKQuantityTypeIdentifier.distanceDownhillSnowSports.rawValue == self){
            return HKQuantityTypeIdentifier.distanceDownhillSnowSports
        }
        if (HKQuantityTypeIdentifier.distanceSwimming.rawValue == self){
            return HKQuantityTypeIdentifier.distanceSwimming
        }
        if (HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue == self){
            return HKQuantityTypeIdentifier.distanceWalkingRunning
        }
        if (HKQuantityTypeIdentifier.distanceWheelchair.rawValue == self){
            return HKQuantityTypeIdentifier.distanceWheelchair
        }
        if (HKQuantityTypeIdentifier.flightsClimbed.rawValue == self){
            return HKQuantityTypeIdentifier.flightsClimbed
        }
        if (HKQuantityTypeIdentifier.nikeFuel.rawValue == self){
            return HKQuantityTypeIdentifier.nikeFuel
        }
        if #available(iOS 17.0, *) {
            if (HKQuantityTypeIdentifier.physicalEffort.rawValue == self){
                return HKQuantityTypeIdentifier.physicalEffort
            }
        }
        if (HKQuantityTypeIdentifier.pushCount.rawValue == self){
            return HKQuantityTypeIdentifier.pushCount
        }
        if (HKQuantityTypeIdentifier.runningPower.rawValue == self){
            return HKQuantityTypeIdentifier.runningPower
        }
        if (HKQuantityTypeIdentifier.runningSpeed.rawValue == self){
            return HKQuantityTypeIdentifier.runningSpeed
        }
        if (HKQuantityTypeIdentifier.stepCount.rawValue == self){
            return HKQuantityTypeIdentifier.stepCount
        }
        if (HKQuantityTypeIdentifier.swimmingStrokeCount.rawValue == self){
            return HKQuantityTypeIdentifier.swimmingStrokeCount
        }
        if (HKQuantityTypeIdentifier.underwaterDepth.rawValue == self){
            return HKQuantityTypeIdentifier.underwaterDepth
        }
        if (HKQuantityTypeIdentifier.environmentalAudioExposure.rawValue == self){
            return HKQuantityTypeIdentifier.environmentalAudioExposure
        }
        if (HKQuantityTypeIdentifier.environmentalSoundReduction.rawValue == self){
            return HKQuantityTypeIdentifier.environmentalSoundReduction
        }
        if (HKQuantityTypeIdentifier.headphoneAudioExposure.rawValue == self){
            return HKQuantityTypeIdentifier.headphoneAudioExposure
        }
        if (HKQuantityTypeIdentifier.atrialFibrillationBurden.rawValue == self){
            return HKQuantityTypeIdentifier.atrialFibrillationBurden
        }
        if (HKQuantityTypeIdentifier.heartRate.rawValue == self){
            return HKQuantityTypeIdentifier.heartRate
        }
        if (HKQuantityTypeIdentifier.heartRateRecoveryOneMinute.rawValue == self){
            return HKQuantityTypeIdentifier.heartRateRecoveryOneMinute
        }
        if (HKQuantityTypeIdentifier.heartRateVariabilitySDNN.rawValue == self){
            return HKQuantityTypeIdentifier.heartRateVariabilitySDNN
        }
        if (HKQuantityTypeIdentifier.peripheralPerfusionIndex.rawValue == self){
            return HKQuantityTypeIdentifier.peripheralPerfusionIndex
        }
        if (HKQuantityTypeIdentifier.restingHeartRate.rawValue == self){
            return HKQuantityTypeIdentifier.restingHeartRate
        }
        if (HKQuantityTypeIdentifier.vo2Max.rawValue == self){
            return HKQuantityTypeIdentifier.vo2Max
        }
        if (HKQuantityTypeIdentifier.walkingHeartRateAverage.rawValue == self){
            return HKQuantityTypeIdentifier.walkingHeartRateAverage
        }
        if (HKQuantityTypeIdentifier.appleWalkingSteadiness.rawValue == self){
            return HKQuantityTypeIdentifier.appleWalkingSteadiness
        }
        if (HKQuantityTypeIdentifier.runningGroundContactTime.rawValue == self){
            return HKQuantityTypeIdentifier.runningGroundContactTime
        }
        if (HKQuantityTypeIdentifier.runningStrideLength.rawValue == self){
            return HKQuantityTypeIdentifier.runningStrideLength
        }
        if (HKQuantityTypeIdentifier.runningVerticalOscillation.rawValue == self){
            return HKQuantityTypeIdentifier.runningVerticalOscillation
        }
        if (HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.rawValue == self){
            return HKQuantityTypeIdentifier.sixMinuteWalkTestDistance
        }
        if (HKQuantityTypeIdentifier.stairAscentSpeed.rawValue == self){
            return HKQuantityTypeIdentifier.stairAscentSpeed
        }
        if (HKQuantityTypeIdentifier.stairDescentSpeed.rawValue == self){
            return HKQuantityTypeIdentifier.stairDescentSpeed
        }
        if (HKQuantityTypeIdentifier.walkingAsymmetryPercentage.rawValue == self){
            return HKQuantityTypeIdentifier.walkingAsymmetryPercentage
        }
        if (HKQuantityTypeIdentifier.walkingDoubleSupportPercentage.rawValue == self){
            return HKQuantityTypeIdentifier.walkingDoubleSupportPercentage
        }
        if (HKQuantityTypeIdentifier.walkingSpeed.rawValue == self){
            return HKQuantityTypeIdentifier.walkingSpeed
        }
        if (HKQuantityTypeIdentifier.walkingStepLength.rawValue == self){
            return HKQuantityTypeIdentifier.walkingStepLength
        }
        if (HKQuantityTypeIdentifier.dietaryBiotin.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryBiotin
        }
        if (HKQuantityTypeIdentifier.dietaryCaffeine.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryCaffeine
        }
        if (HKQuantityTypeIdentifier.dietaryCalcium.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryCalcium
        }
        if (HKQuantityTypeIdentifier.dietaryCarbohydrates.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryCarbohydrates
        }
        if (HKQuantityTypeIdentifier.dietaryChloride.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryChloride
        }
        if (HKQuantityTypeIdentifier.dietaryCholesterol.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryCholesterol
        }
        if (HKQuantityTypeIdentifier.dietaryChromium.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryChromium
        }
        if (HKQuantityTypeIdentifier.dietaryCopper.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryCopper
        }
        if (HKQuantityTypeIdentifier.dietaryEnergyConsumed.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryEnergyConsumed
        }
        if (HKQuantityTypeIdentifier.dietaryFatMonounsaturated.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFatMonounsaturated
        }
        if (HKQuantityTypeIdentifier.dietaryFatPolyunsaturated.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFatPolyunsaturated
        }
        if (HKQuantityTypeIdentifier.dietaryFatSaturated.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFatSaturated
        }
        if (HKQuantityTypeIdentifier.dietaryFatTotal.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFatTotal
        }
        if (HKQuantityTypeIdentifier.dietaryFiber.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFiber
        }
        if (HKQuantityTypeIdentifier.dietaryFolate.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryFolate
        }
        if (HKQuantityTypeIdentifier.dietaryIodine.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryIodine
        }
        if (HKQuantityTypeIdentifier.dietaryIron.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryIron
        }
        if (HKQuantityTypeIdentifier.dietaryMagnesium.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryMagnesium
        }
        if (HKQuantityTypeIdentifier.dietaryManganese.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryManganese
        }
        if (HKQuantityTypeIdentifier.dietaryMolybdenum.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryMolybdenum
        }
        if (HKQuantityTypeIdentifier.dietaryNiacin.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryNiacin
        }
        if (HKQuantityTypeIdentifier.dietaryPantothenicAcid.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryPantothenicAcid
        }
        if (HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryPhosphorus
        }
        if (HKQuantityTypeIdentifier.dietaryPotassium.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryPotassium
        }
        if (HKQuantityTypeIdentifier.dietaryProtein.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryProtein
        }
        if (HKQuantityTypeIdentifier.dietaryRiboflavin.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryRiboflavin
        }
        if (HKQuantityTypeIdentifier.dietarySelenium.rawValue == self){
            return HKQuantityTypeIdentifier.dietarySelenium
        }
        if (HKQuantityTypeIdentifier.dietarySodium.rawValue == self){
            return HKQuantityTypeIdentifier.dietarySodium
        }
        if (HKQuantityTypeIdentifier.dietarySugar.rawValue == self){
            return HKQuantityTypeIdentifier.dietarySugar
        }
        if (HKQuantityTypeIdentifier.dietaryThiamin.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryThiamin
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminA.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminA
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminB12.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminB12
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminB6.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminB6
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminC.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminC
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminD.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminD
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminE.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminE
        }
        if (HKQuantityTypeIdentifier.dietaryVitaminK.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryVitaminK
        }
        if (HKQuantityTypeIdentifier.dietaryWater.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryWater
        }
        if (HKQuantityTypeIdentifier.dietaryZinc.rawValue == self){
            return HKQuantityTypeIdentifier.dietaryZinc
        }
        if (HKQuantityTypeIdentifier.bloodAlcoholContent.rawValue == self){
            return HKQuantityTypeIdentifier.bloodAlcoholContent
        }
        if (HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue == self){
            return HKQuantityTypeIdentifier.bloodPressureDiastolic
        }
        if (HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue == self){
            return HKQuantityTypeIdentifier.bloodPressureSystolic
        }
        if (HKQuantityTypeIdentifier.insulinDelivery.rawValue == self){
            return HKQuantityTypeIdentifier.insulinDelivery
        }
        if (HKQuantityTypeIdentifier.numberOfAlcoholicBeverages.rawValue == self){
            return HKQuantityTypeIdentifier.numberOfAlcoholicBeverages
        }
        if (HKQuantityTypeIdentifier.numberOfTimesFallen.rawValue == self){
            return HKQuantityTypeIdentifier.numberOfTimesFallen
        }
        if #available(iOS 17.0, *) {
            if (HKQuantityTypeIdentifier.timeInDaylight.rawValue == self){
                return HKQuantityTypeIdentifier.timeInDaylight
            }
        }
        if (HKQuantityTypeIdentifier.uvExposure.rawValue == self){
            return HKQuantityTypeIdentifier.uvExposure
        }
        if (HKQuantityTypeIdentifier.waterTemperature.rawValue == self){
            return HKQuantityTypeIdentifier.waterTemperature
        }
        if (HKQuantityTypeIdentifier.basalBodyTemperature.rawValue == self){
            return HKQuantityTypeIdentifier.basalBodyTemperature
        }
        if (HKQuantityTypeIdentifier.forcedExpiratoryVolume1.rawValue == self){
            return HKQuantityTypeIdentifier.forcedExpiratoryVolume1
        }
        if (HKQuantityTypeIdentifier.forcedVitalCapacity.rawValue == self){
            return HKQuantityTypeIdentifier.forcedVitalCapacity
        }
        if (HKQuantityTypeIdentifier.inhalerUsage.rawValue == self){
            return HKQuantityTypeIdentifier.inhalerUsage
        }
        if (HKQuantityTypeIdentifier.oxygenSaturation.rawValue == self){
            return HKQuantityTypeIdentifier.oxygenSaturation
        }
        if (HKQuantityTypeIdentifier.peakExpiratoryFlowRate.rawValue == self){
            return HKQuantityTypeIdentifier.peakExpiratoryFlowRate
        }
        if (HKQuantityTypeIdentifier.respiratoryRate.rawValue == self){
            return HKQuantityTypeIdentifier.respiratoryRate
        }
        if (HKQuantityTypeIdentifier.bloodGlucose.rawValue == self){
            return HKQuantityTypeIdentifier.bloodGlucose
        }
        if (HKQuantityTypeIdentifier.bodyTemperature.rawValue == self){
            return HKQuantityTypeIdentifier.bodyTemperature
        }
        return nil
    }
}
extension String {
    var categoryTypeIdentifier: HKCategoryTypeIdentifier? {
        if (HKCategoryTypeIdentifier.appleStandHour.rawValue == self){
            return HKCategoryTypeIdentifier.appleStandHour
        }
        if (HKCategoryTypeIdentifier.environmentalAudioExposureEvent.rawValue == self){
            return HKCategoryTypeIdentifier.environmentalAudioExposureEvent
        }
        if (HKCategoryTypeIdentifier.headphoneAudioExposureEvent.rawValue == self){
            return HKCategoryTypeIdentifier.headphoneAudioExposureEvent
        }
        if (HKCategoryTypeIdentifier.highHeartRateEvent.rawValue == self){
            return HKCategoryTypeIdentifier.highHeartRateEvent
        }
        if (HKCategoryTypeIdentifier.irregularHeartRhythmEvent.rawValue == self){
            return HKCategoryTypeIdentifier.irregularHeartRhythmEvent
        }
        if (HKCategoryTypeIdentifier.lowCardioFitnessEvent.rawValue == self){
            return HKCategoryTypeIdentifier.lowCardioFitnessEvent
        }
        if (HKCategoryTypeIdentifier.lowHeartRateEvent.rawValue == self){
            return HKCategoryTypeIdentifier.lowHeartRateEvent
        }
        if (HKCategoryTypeIdentifier.mindfulSession.rawValue == self){
            return HKCategoryTypeIdentifier.mindfulSession
        }
        if (HKCategoryTypeIdentifier.appleWalkingSteadinessEvent.rawValue == self){
            return HKCategoryTypeIdentifier.appleWalkingSteadinessEvent
        }
        if (HKCategoryTypeIdentifier.handwashingEvent.rawValue == self){
            return HKCategoryTypeIdentifier.handwashingEvent
        }
        if (HKCategoryTypeIdentifier.toothbrushingEvent.rawValue == self){
            return HKCategoryTypeIdentifier.toothbrushingEvent
        }
        if (HKCategoryTypeIdentifier.cervicalMucusQuality.rawValue == self){
            return HKCategoryTypeIdentifier.cervicalMucusQuality
        }
        if (HKCategoryTypeIdentifier.contraceptive.rawValue == self){
            return HKCategoryTypeIdentifier.contraceptive
        }
        if (HKCategoryTypeIdentifier.infrequentMenstrualCycles.rawValue == self){
            return HKCategoryTypeIdentifier.infrequentMenstrualCycles
        }
        if (HKCategoryTypeIdentifier.intermenstrualBleeding.rawValue == self){
            return HKCategoryTypeIdentifier.intermenstrualBleeding
        }
        if (HKCategoryTypeIdentifier.irregularMenstrualCycles.rawValue == self){
            return HKCategoryTypeIdentifier.irregularMenstrualCycles
        }
        if (HKCategoryTypeIdentifier.lactation.rawValue == self){
            return HKCategoryTypeIdentifier.lactation
        }
        if (HKCategoryTypeIdentifier.menstrualFlow.rawValue == self){
            return HKCategoryTypeIdentifier.menstrualFlow
        }
        if (HKCategoryTypeIdentifier.ovulationTestResult.rawValue == self){
            return HKCategoryTypeIdentifier.ovulationTestResult
        }
        if (HKCategoryTypeIdentifier.persistentIntermenstrualBleeding.rawValue == self){
            return HKCategoryTypeIdentifier.persistentIntermenstrualBleeding
        }
        if (HKCategoryTypeIdentifier.pregnancy.rawValue == self){
            return HKCategoryTypeIdentifier.pregnancy
        }
        if (HKCategoryTypeIdentifier.pregnancyTestResult.rawValue == self){
            return HKCategoryTypeIdentifier.pregnancyTestResult
        }
        if (HKCategoryTypeIdentifier.progesteroneTestResult.rawValue == self){
            return HKCategoryTypeIdentifier.progesteroneTestResult
        }
        if (HKCategoryTypeIdentifier.prolongedMenstrualPeriods.rawValue == self){
            return HKCategoryTypeIdentifier.prolongedMenstrualPeriods
        }
        if (HKCategoryTypeIdentifier.sexualActivity.rawValue == self){
            return HKCategoryTypeIdentifier.sexualActivity
        }
        if (HKCategoryTypeIdentifier.sleepAnalysis.rawValue == self){
            return HKCategoryTypeIdentifier.sleepAnalysis
        }
        if (HKCategoryTypeIdentifier.abdominalCramps.rawValue == self){
            return HKCategoryTypeIdentifier.abdominalCramps
        }
        if (HKCategoryTypeIdentifier.acne.rawValue == self){
            return HKCategoryTypeIdentifier.acne
        }
        if (HKCategoryTypeIdentifier.appetiteChanges.rawValue == self){
            return HKCategoryTypeIdentifier.appetiteChanges
        }
        if (HKCategoryTypeIdentifier.bladderIncontinence.rawValue == self){
            return HKCategoryTypeIdentifier.bladderIncontinence
        }
        if (HKCategoryTypeIdentifier.bloating.rawValue == self){
            return HKCategoryTypeIdentifier.bloating
        }
        if (HKCategoryTypeIdentifier.breastPain.rawValue == self){
            return HKCategoryTypeIdentifier.breastPain
        }
        if (HKCategoryTypeIdentifier.chestTightnessOrPain.rawValue == self){
            return HKCategoryTypeIdentifier.chestTightnessOrPain
        }
        if (HKCategoryTypeIdentifier.chills.rawValue == self){
            return HKCategoryTypeIdentifier.chills
        }
        if (HKCategoryTypeIdentifier.constipation.rawValue == self){
            return HKCategoryTypeIdentifier.constipation
        }
        if (HKCategoryTypeIdentifier.coughing.rawValue == self){
            return HKCategoryTypeIdentifier.coughing
        }
        if (HKCategoryTypeIdentifier.diarrhea.rawValue == self){
            return HKCategoryTypeIdentifier.diarrhea
        }
        if (HKCategoryTypeIdentifier.dizziness.rawValue == self){
            return HKCategoryTypeIdentifier.dizziness
        }
        if (HKCategoryTypeIdentifier.drySkin.rawValue == self){
            return HKCategoryTypeIdentifier.drySkin
        }
        if (HKCategoryTypeIdentifier.fainting.rawValue == self){
            return HKCategoryTypeIdentifier.fainting
        }
        if (HKCategoryTypeIdentifier.fatigue.rawValue == self){
            return HKCategoryTypeIdentifier.fatigue
        }
        if (HKCategoryTypeIdentifier.fever.rawValue == self){
            return HKCategoryTypeIdentifier.fever
        }
        if (HKCategoryTypeIdentifier.generalizedBodyAche.rawValue == self){
            return HKCategoryTypeIdentifier.generalizedBodyAche
        }
        if (HKCategoryTypeIdentifier.hairLoss.rawValue == self){
            return HKCategoryTypeIdentifier.hairLoss
        }
        if (HKCategoryTypeIdentifier.headache.rawValue == self){
            return HKCategoryTypeIdentifier.headache
        }
        if (HKCategoryTypeIdentifier.heartburn.rawValue == self){
            return HKCategoryTypeIdentifier.heartburn
        }
        if (HKCategoryTypeIdentifier.hotFlashes.rawValue == self){
            return HKCategoryTypeIdentifier.hotFlashes
        }
        if (HKCategoryTypeIdentifier.lossOfSmell.rawValue == self){
            return HKCategoryTypeIdentifier.lossOfSmell
        }
        if (HKCategoryTypeIdentifier.lossOfTaste.rawValue == self){
            return HKCategoryTypeIdentifier.lossOfTaste
        }
        if (HKCategoryTypeIdentifier.lowerBackPain.rawValue == self){
            return HKCategoryTypeIdentifier.lowerBackPain
        }
        if (HKCategoryTypeIdentifier.memoryLapse.rawValue == self){
            return HKCategoryTypeIdentifier.memoryLapse
        }
        if (HKCategoryTypeIdentifier.moodChanges.rawValue == self){
            return HKCategoryTypeIdentifier.moodChanges
        }
        if (HKCategoryTypeIdentifier.nausea.rawValue == self){
            return HKCategoryTypeIdentifier.nausea
        }
        if (HKCategoryTypeIdentifier.nightSweats.rawValue == self){
            return HKCategoryTypeIdentifier.nightSweats
        }
        if (HKCategoryTypeIdentifier.pelvicPain.rawValue == self){
            return HKCategoryTypeIdentifier.pelvicPain
        }
        if (HKCategoryTypeIdentifier.rapidPoundingOrFlutteringHeartbeat.rawValue == self){
            return HKCategoryTypeIdentifier.rapidPoundingOrFlutteringHeartbeat
        }
        if (HKCategoryTypeIdentifier.runnyNose.rawValue == self){
            return HKCategoryTypeIdentifier.runnyNose
        }
        if (HKCategoryTypeIdentifier.shortnessOfBreath.rawValue == self){
            return HKCategoryTypeIdentifier.shortnessOfBreath
        }
        if (HKCategoryTypeIdentifier.sinusCongestion.rawValue == self){
            return HKCategoryTypeIdentifier.sinusCongestion
        }
        if (HKCategoryTypeIdentifier.skippedHeartbeat.rawValue == self){
            return HKCategoryTypeIdentifier.skippedHeartbeat
        }
        if (HKCategoryTypeIdentifier.sleepChanges.rawValue == self){
            return HKCategoryTypeIdentifier.sleepChanges
        }
        if (HKCategoryTypeIdentifier.soreThroat.rawValue == self){
            return HKCategoryTypeIdentifier.soreThroat
        }
        if (HKCategoryTypeIdentifier.vaginalDryness.rawValue == self){
            return HKCategoryTypeIdentifier.vaginalDryness
        }
        if (HKCategoryTypeIdentifier.vomiting.rawValue == self){
            return HKCategoryTypeIdentifier.vomiting
        }
        if (HKCategoryTypeIdentifier.wheezing.rawValue == self){
            return HKCategoryTypeIdentifier.wheezing
        }
        if (HKCategoryTypeIdentifier.audioExposureEvent.rawValue == self){
            return HKCategoryTypeIdentifier.audioExposureEvent
        }
        return nil
    }
}
extension String {
    var characteristicTypeIdentifier: HKCharacteristicTypeIdentifier? {
        if (HKCharacteristicTypeIdentifier.biologicalSex.rawValue == self){
            return HKCharacteristicTypeIdentifier.biologicalSex
        }
        if (HKCharacteristicTypeIdentifier.bloodType.rawValue == self){
            return HKCharacteristicTypeIdentifier.bloodType
        }
        if (HKCharacteristicTypeIdentifier.dateOfBirth.rawValue == self){
            return HKCharacteristicTypeIdentifier.dateOfBirth
        }
        if (HKCharacteristicTypeIdentifier.fitzpatrickSkinType.rawValue == self){
            return HKCharacteristicTypeIdentifier.fitzpatrickSkinType
        }
        if (HKCharacteristicTypeIdentifier.wheelchairUse.rawValue == self){
            return HKCharacteristicTypeIdentifier.wheelchairUse
        }
        if (HKCharacteristicTypeIdentifier.activityMoveMode.rawValue == self){
            return HKCharacteristicTypeIdentifier.activityMoveMode
        }
        debugPrint("Unknown HKCharacteristicTypeIdentifier for \(self)")
        return nil
    }
}
extension String {
    var correlationTypeIdentifier: HKCorrelationTypeIdentifier? {
        if (HKCorrelationTypeIdentifier.bloodPressure.rawValue == self){
            return HKCorrelationTypeIdentifier.bloodPressure
        }
        if (HKCorrelationTypeIdentifier.food.rawValue == self){
            return HKCorrelationTypeIdentifier.food
        }
        return nil
    }
}
extension String {
    var documentTypeIdentifier: HKDocumentTypeIdentifier? {
        if (HKDocumentTypeIdentifier.CDA.rawValue == self){
            return HKDocumentTypeIdentifier.CDA
        }
        return nil
    }
}
extension String {
    var clinicalTypeIdentifier: HKClinicalTypeIdentifier? {
        if (HKClinicalTypeIdentifier.allergyRecord.rawValue == self){
            return HKClinicalTypeIdentifier.allergyRecord
        }
        if #available(iOS 16.4, *) {
            if (HKClinicalTypeIdentifier.clinicalNoteRecord.rawValue == self){
                return HKClinicalTypeIdentifier.clinicalNoteRecord
            }
        }
        if (HKClinicalTypeIdentifier.conditionRecord.rawValue == self){
            return HKClinicalTypeIdentifier.conditionRecord
        }
        if (HKClinicalTypeIdentifier.immunizationRecord.rawValue == self){
            return HKClinicalTypeIdentifier.immunizationRecord
        }
        if (HKClinicalTypeIdentifier.labResultRecord.rawValue == self){
            return HKClinicalTypeIdentifier.labResultRecord
        }
        if (HKClinicalTypeIdentifier.medicationRecord.rawValue == self){
            return HKClinicalTypeIdentifier.medicationRecord
        }
        if (HKClinicalTypeIdentifier.procedureRecord.rawValue == self){
            return HKClinicalTypeIdentifier.procedureRecord
        }
        if (HKClinicalTypeIdentifier.vitalSignRecord.rawValue == self){
            return HKClinicalTypeIdentifier.vitalSignRecord
        }
        if (HKClinicalTypeIdentifier.coverageRecord.rawValue == self){
            return HKClinicalTypeIdentifier.coverageRecord
        }
        return nil
    }
}
