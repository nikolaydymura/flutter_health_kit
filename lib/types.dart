import 'package:collection/collection.dart';

abstract class ObjectTypeId {
  factory ObjectTypeId.fromIdentifier(String identifier) {
    final values = <ObjectTypeId>[
      ...HKSampleTypeIdentifier.values,
      ...HKQuantityTypeIdentifier.values,
      ...HKCategoryTypeIdentifier.values,
      ...HKCharacteristicTypeIdentifier.values,
      ...HKCorrelationTypeIdentifier.values,
      ...HKDocumentTypeIdentifier.values,
    ];
    final type = values.firstWhereOrNull(
      (e) => e.identifier == identifier,
    );
    if (type == null) {
      throw ArgumentError.value(
        identifier,
        'identifier',
        'Invalid identifier: $identifier',
      );
    }
    return type;
  }

  const ObjectTypeId._();

  String get identifier;
}

abstract class SampleTypeId extends ObjectTypeId {
  const SampleTypeId._() : super._();
}

enum HKQuantityTypeIdentifier implements SampleTypeId {
  appleSleepingWristTemperature._(
    'HKQuantityTypeIdentifierAppleSleepingWristTemperature',
  ),
  bodyFatPercentage._('HKQuantityTypeIdentifierBodyFatPercentage'),
  bodyMass._('HKQuantityTypeIdentifierBodyMass'),
  bodyMassIndex._('HKQuantityTypeIdentifierBodyMassIndex'),
  electrodermalActivity._('HKQuantityTypeIdentifierElectrodermalActivity'),
  height._('HKQuantityTypeIdentifierHeight'),
  leanBodyMass._('HKQuantityTypeIdentifierLeanBodyMass'),
  waistCircumference._('HKQuantityTypeIdentifierWaistCircumference'),
  activeEnergyBurned._('HKQuantityTypeIdentifierActiveEnergyBurned'),
  appleExerciseTime._('HKQuantityTypeIdentifierAppleExerciseTime'),
  appleMoveTime._('HKQuantityTypeIdentifierAppleMoveTime'),
  appleStandTime._('HKQuantityTypeIdentifierAppleStandTime'),
  basalEnergyBurned._('HKQuantityTypeIdentifierBasalEnergyBurned'),
  cyclingCadence._('HKQuantityTypeIdentifierCyclingCadence'),
  cyclingFunctionalThresholdPower._(
    'HKQuantityTypeIdentifierCyclingFunctionalThresholdPower',
  ),
  cyclingPower._('HKQuantityTypeIdentifierCyclingPower'),
  cyclingSpeed._('HKQuantityTypeIdentifierCyclingSpeed'),
  distanceCycling._('HKQuantityTypeIdentifierDistanceCycling'),
  distanceDownhillSnowSports._(
    'HKQuantityTypeIdentifierDistanceDownhillSnowSports',
  ),
  distanceSwimming._('HKQuantityTypeIdentifierDistanceSwimming'),
  distanceWalkingRunning._('HKQuantityTypeIdentifierDistanceWalkingRunning'),
  distanceWheelchair._('HKQuantityTypeIdentifierDistanceWheelchair'),
  flightsClimbed._('HKQuantityTypeIdentifierFlightsClimbed'),
  nikeFuel._('HKQuantityTypeIdentifierNikeFuel'),
  physicalEffort._('HKQuantityTypeIdentifierPhysicalEffort'),
  pushCount._('HKQuantityTypeIdentifierPushCount'),
  runningPower._('HKQuantityTypeIdentifierRunningPower'),
  runningSpeed._('HKQuantityTypeIdentifierRunningSpeed'),
  stepCount._('HKQuantityTypeIdentifierStepCount'),
  swimmingStrokeCount._('HKQuantityTypeIdentifierSwimmingStrokeCount'),
  underwaterDepth._('HKQuantityTypeIdentifierUnderwaterDepth'),
  environmentalAudioExposure._(
    'HKQuantityTypeIdentifierEnvironmentalAudioExposure',
  ),
  environmentalSoundReduction._(
    'HKQuantityTypeIdentifierEnvironmentalSoundReduction',
  ),
  headphoneAudioExposure._('HKQuantityTypeIdentifierHeadphoneAudioExposure'),
  atrialFibrillationBurden._(
    'HKQuantityTypeIdentifierAtrialFibrillationBurden',
  ),
  heartRate._('HKQuantityTypeIdentifierHeartRate'),
  heartRateRecoveryOneMinute._(
    'HKQuantityTypeIdentifierHeartRateRecoveryOneMinute',
  ),
  heartRateVariabilitySDNN._(
    'HKQuantityTypeIdentifierHeartRateVariabilitySDNN',
  ),
  peripheralPerfusionIndex._(
    'HKQuantityTypeIdentifierPeripheralPerfusionIndex',
  ),
  restingHeartRate._('HKQuantityTypeIdentifierRestingHeartRate'),
  vo2Max._('HKQuantityTypeIdentifierVO2Max'),
  walkingHeartRateAverage._('HKQuantityTypeIdentifierWalkingHeartRateAverage'),
  appleWalkingSteadiness._('HKQuantityTypeIdentifierAppleWalkingSteadiness'),
  runningGroundContactTime._(
    'HKQuantityTypeIdentifierRunningGroundContactTime',
  ),
  runningStrideLength._('HKQuantityTypeIdentifierRunningStrideLength'),
  runningVerticalOscillation._(
    'HKQuantityTypeIdentifierRunningVerticalOscillation',
  ),
  sixMinuteWalkTestDistance._(
    'HKQuantityTypeIdentifierSixMinuteWalkTestDistance',
  ),
  stairAscentSpeed._('HKQuantityTypeIdentifierStairAscentSpeed'),
  stairDescentSpeed._('HKQuantityTypeIdentifierStairDescentSpeed'),
  walkingAsymmetryPercentage._(
    'HKQuantityTypeIdentifierWalkingAsymmetryPercentage',
  ),
  walkingDoubleSupportPercentage._(
    'HKQuantityTypeIdentifierWalkingDoubleSupportPercentage',
  ),
  walkingSpeed._('HKQuantityTypeIdentifierWalkingSpeed'),
  walkingStepLength._('HKQuantityTypeIdentifierWalkingStepLength'),
  dietaryBiotin._('HKQuantityTypeIdentifierDietaryBiotin'),
  dietaryCaffeine._('HKQuantityTypeIdentifierDietaryCaffeine'),
  dietaryCalcium._('HKQuantityTypeIdentifierDietaryCalcium'),
  dietaryCarbohydrates._('HKQuantityTypeIdentifierDietaryCarbohydrates'),
  dietaryChloride._('HKQuantityTypeIdentifierDietaryChloride'),
  dietaryCholesterol._('HKQuantityTypeIdentifierDietaryCholesterol'),
  dietaryChromium._('HKQuantityTypeIdentifierDietaryChromium'),
  dietaryCopper._('HKQuantityTypeIdentifierDietaryCopper'),
  dietaryEnergyConsumed._('HKQuantityTypeIdentifierDietaryEnergyConsumed'),
  dietaryFatMonounsaturated._(
    'HKQuantityTypeIdentifierDietaryFatMonounsaturated',
  ),
  dietaryFatPolyunsaturated._(
    'HKQuantityTypeIdentifierDietaryFatPolyunsaturated',
  ),
  dietaryFatSaturated._('HKQuantityTypeIdentifierDietaryFatSaturated'),
  dietaryFatTotal._('HKQuantityTypeIdentifierDietaryFatTotal'),
  dietaryFiber._('HKQuantityTypeIdentifierDietaryFiber'),
  dietaryFolate._('HKQuantityTypeIdentifierDietaryFolate'),
  dietaryIodine._('HKQuantityTypeIdentifierDietaryIodine'),
  dietaryIron._('HKQuantityTypeIdentifierDietaryIron'),
  dietaryMagnesium._('HKQuantityTypeIdentifierDietaryMagnesium'),
  dietaryManganese._('HKQuantityTypeIdentifierDietaryManganese'),
  dietaryMolybdenum._('HKQuantityTypeIdentifierDietaryMolybdenum'),
  dietaryNiacin._('HKQuantityTypeIdentifierDietaryNiacin'),
  dietaryPantothenicAcid._('HKQuantityTypeIdentifierDietaryPantothenicAcid'),
  dietaryPhosphorus._('HKQuantityTypeIdentifierDietaryPhosphorus'),
  dietaryPotassium._('HKQuantityTypeIdentifierDietaryPotassium'),
  dietaryProtein._('HKQuantityTypeIdentifierDietaryProtein'),
  dietaryRiboflavin._('HKQuantityTypeIdentifierDietaryRiboflavin'),
  dietarySelenium._('HKQuantityTypeIdentifierDietarySelenium'),
  dietarySodium._('HKQuantityTypeIdentifierDietarySodium'),
  dietarySugar._('HKQuantityTypeIdentifierDietarySugar'),
  dietaryThiamin._('HKQuantityTypeIdentifierDietaryThiamin'),
  dietaryVitaminA._('HKQuantityTypeIdentifierDietaryVitaminA'),
  dietaryVitaminB12._('HKQuantityTypeIdentifierDietaryVitaminB12'),
  dietaryVitaminB6._('HKQuantityTypeIdentifierDietaryVitaminB6'),
  dietaryVitaminC._('HKQuantityTypeIdentifierDietaryVitaminC'),
  dietaryVitaminD._('HKQuantityTypeIdentifierDietaryVitaminD'),
  dietaryVitaminE._('HKQuantityTypeIdentifierDietaryVitaminE'),
  dietaryVitaminK._('HKQuantityTypeIdentifierDietaryVitaminK'),
  dietaryWater._('HKQuantityTypeIdentifierDietaryWater'),
  dietaryZinc._('HKQuantityTypeIdentifierDietaryZinc'),
  bloodAlcoholContent._('HKQuantityTypeIdentifierBloodAlcoholContent'),
  bloodPressureDiastolic._('HKQuantityTypeIdentifierBloodPressureDiastolic'),
  bloodPressureSystolic._('HKQuantityTypeIdentifierBloodPressureSystolic'),
  insulinDelivery._('HKQuantityTypeIdentifierInsulinDelivery'),
  numberOfAlcoholicBeverages._(
    'HKQuantityTypeIdentifierNumberOfAlcoholicBeverages',
  ),
  numberOfTimesFallen._('HKQuantityTypeIdentifierNumberOfTimesFallen'),
  timeInDaylight._('HKQuantityTypeIdentifierTimeInDaylight'),
  uvExposure._('HKQuantityTypeIdentifierUVExposure'),
  waterTemperature._('HKQuantityTypeIdentifierWaterTemperature'),
  basalBodyTemperature._('HKQuantityTypeIdentifierBasalBodyTemperature'),
  forcedExpiratoryVolume1._('HKQuantityTypeIdentifierForcedExpiratoryVolume1'),
  forcedVitalCapacity._('HKQuantityTypeIdentifierForcedVitalCapacity'),
  inhalerUsage._('HKQuantityTypeIdentifierInhalerUsage'),
  oxygenSaturation._('HKQuantityTypeIdentifierOxygenSaturation'),
  peakExpiratoryFlowRate._('HKQuantityTypeIdentifierPeakExpiratoryFlowRate'),
  respiratoryRate._('HKQuantityTypeIdentifierRespiratoryRate'),
  bloodGlucose._('HKQuantityTypeIdentifierBloodGlucose'),
  bodyTemperature._('HKQuantityTypeIdentifierBodyTemperature');

  const HKQuantityTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}

enum HKCategoryTypeIdentifier implements SampleTypeId {
  appleStandHour._('HKCategoryTypeIdentifierAppleStandHour'),
  environmentalAudioExposureEvent._(
    'HKCategoryTypeIdentifierAudioExposureEvent',
  ),
  headphoneAudioExposureEvent._(
    'HKCategoryTypeIdentifierHeadphoneAudioExposureEvent',
  ),
  highHeartRateEvent._('HKCategoryTypeIdentifierHighHeartRateEvent'),
  irregularHeartRhythmEvent._(
    'HKCategoryTypeIdentifierIrregularHeartRhythmEvent',
  ),
  lowCardioFitnessEvent._('HKCategoryTypeIdentifierLowCardioFitnessEvent'),
  lowHeartRateEvent._('HKCategoryTypeIdentifierLowHeartRateEvent'),
  mindfulSession._('HKCategoryTypeIdentifierMindfulSession'),
  appleWalkingSteadinessEvent._(
    'HKCategoryTypeIdentifierAppleWalkingSteadinessEvent',
  ),
  handwashingEvent._('HKCategoryTypeIdentifierHandwashingEvent'),
  toothbrushingEvent._('HKCategoryTypeIdentifierToothbrushingEvent'),
  cervicalMucusQuality._('HKCategoryTypeIdentifierCervicalMucusQuality'),
  contraceptive._('HKCategoryTypeIdentifierContraceptive'),
  infrequentMenstrualCycles._(
    'HKCategoryTypeIdentifierInfrequentMenstrualCycles',
  ),
  intermenstrualBleeding._('HKCategoryTypeIdentifierIntermenstrualBleeding'),
  irregularMenstrualCycles._(
    'HKCategoryTypeIdentifierIrregularMenstrualCycles',
  ),
  lactation._('HKCategoryTypeIdentifierLactation'),
  menstrualFlow._('HKCategoryTypeIdentifierMenstrualFlow'),
  ovulationTestResult._('HKCategoryTypeIdentifierOvulationTestResult'),
  persistentIntermenstrualBleeding._(
    'HKCategoryTypeIdentifierPersistentIntermenstrualBleeding',
  ),
  pregnancy._('HKCategoryTypeIdentifierPregnancy'),
  pregnancyTestResult._('HKCategoryTypeIdentifierPregnancyTestResult'),
  progesteroneTestResult._('HKCategoryTypeIdentifierProgesteroneTestResult'),
  prolongedMenstrualPeriods._(
    'HKCategoryTypeIdentifierProlongedMenstrualPeriods',
  ),
  sexualActivity._('HKCategoryTypeIdentifierSexualActivity'),
  sleepAnalysis._('HKCategoryTypeIdentifierSleepAnalysis'),
  abdominalCramps._('HKCategoryTypeIdentifierAbdominalCramps'),
  acne._('HKCategoryTypeIdentifierAcne'),
  appetiteChanges._('HKCategoryTypeIdentifierAppetiteChanges'),
  bladderIncontinence._('HKCategoryTypeIdentifierBladderIncontinence'),
  bloating._('HKCategoryTypeIdentifierBloating'),
  breastPain._('HKCategoryTypeIdentifierBreastPain'),
  chestTightnessOrPain._('HKCategoryTypeIdentifierChestTightnessOrPain'),
  chills._('HKCategoryTypeIdentifierChills'),
  constipation._('HKCategoryTypeIdentifierConstipation'),
  coughing._('HKCategoryTypeIdentifierCoughing'),
  diarrhea._('HKCategoryTypeIdentifierDiarrhea'),
  dizziness._('HKCategoryTypeIdentifierDizziness'),
  drySkin._('HKCategoryTypeIdentifierDrySkin'),
  fainting._('HKCategoryTypeIdentifierFainting'),
  fatigue._('HKCategoryTypeIdentifierFatigue'),
  fever._('HKCategoryTypeIdentifierFever'),
  generalizedBodyAche._('HKCategoryTypeIdentifierGeneralizedBodyAche'),
  hairLoss._('HKCategoryTypeIdentifierHairLoss'),
  headache._('HKCategoryTypeIdentifierHeadache'),
  heartburn._('HKCategoryTypeIdentifierHeartburn'),
  hotFlashes._('HKCategoryTypeIdentifierHotFlashes'),
  lossOfSmell._('HKCategoryTypeIdentifierLossOfSmell'),
  lossOfTaste._('HKCategoryTypeIdentifierLossOfTaste'),
  lowerBackPain._('HKCategoryTypeIdentifierLowerBackPain'),
  memoryLapse._('HKCategoryTypeIdentifierMemoryLapse'),
  moodChanges._('HKCategoryTypeIdentifierMoodChanges'),
  nausea._('HKCategoryTypeIdentifierNausea'),
  nightSweats._('HKCategoryTypeIdentifierNightSweats'),
  pelvicPain._('HKCategoryTypeIdentifierPelvicPain'),
  rapidPoundingOrFlutteringHeartbeat._(
    'HKCategoryTypeIdentifierRapidPoundingOrFlutteringHeartbeat',
  ),
  runnyNose._('HKCategoryTypeIdentifierRunnyNose'),
  shortnessOfBreath._('HKCategoryTypeIdentifierShortnessOfBreath'),
  sinusCongestion._('HKCategoryTypeIdentifierSinusCongestion'),
  skippedHeartbeat._('HKCategoryTypeIdentifierSkippedHeartbeat'),
  sleepChanges._('HKCategoryTypeIdentifierSleepChanges'),
  soreThroat._('HKCategoryTypeIdentifierSoreThroat'),
  vaginalDryness._('HKCategoryTypeIdentifierVaginalDryness'),
  vomiting._('HKCategoryTypeIdentifierVomiting'),
  wheezing._('HKCategoryTypeIdentifierWheezing'),
  audioExposureEvent._('HKCategoryTypeIdentifierAudioExposureEvent');

  const HKCategoryTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}

enum HKCharacteristicTypeIdentifier implements SampleTypeId {
  biologicalSex._('HKCharacteristicTypeIdentifierBiologicalSex'),
  bloodType._('HKCharacteristicTypeIdentifierBloodType'),
  dateOfBirth._('HKCharacteristicTypeIdentifierDateOfBirth'),
  fitzpatrickSkinType._('HKCharacteristicTypeIdentifierFitzpatrickSkinType'),
  wheelchairUse._('HKCharacteristicTypeIdentifierWheelchairUse'),
  activityMoveMode._('HKCharacteristicTypeIdentifierActivityMoveMode');

  const HKCharacteristicTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}

enum HKCorrelationTypeIdentifier implements SampleTypeId {
  bloodPressure._('HKCorrelationTypeIdentifierBloodPressure'),
  food._('HKCorrelationTypeIdentifierFood');

  const HKCorrelationTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}

enum HKDocumentTypeIdentifier implements SampleTypeId {
  cda._('HKDocumentTypeIdentifierCDA');

  const HKDocumentTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}

enum HKSampleTypeIdentifier implements SampleTypeId {
  workout._('HKWorkoutTypeIdentifier'),
  workoutRoute._('HKWorkoutRouteTypeIdentifier'),
  dataHeartbeatSeries._('HKDataTypeIdentifierHeartbeatSeries'),
  visionPrescription._('HKVisionPrescriptionTypeIdentifier'),
  dataElectrocardiogram._('HKDataTypeIdentifierElectrocardiogram'),
  dataAudiogram._('HKDataTypeIdentifierAudiogram');

  const HKSampleTypeIdentifier._(this.identifier);

  @override
  final String identifier;
}
