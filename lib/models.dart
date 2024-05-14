import 'package:collection/collection.dart';

import 'types.dart';

/// A sample of data collected by HealthKit.
abstract class Sample {
  Sample({
    required this.uuid,
    required this.start,
    required this.end,
    required this.sourceRevision,
    required this.device,
    required this.metadata,
    required this.type,
  });

  /// The unique identifier of the sample.
  final String uuid;

  /// The start date of the sample.
  final DateTime start;

  /// The end date of the sample.
  final DateTime end;

  /// The source revision of the sample.
  final SourceRevision sourceRevision;

  /// The device that collected the sample.
  final Device? device;

  /// Additional metadata for the sample.
  final Map<String, dynamic>? metadata;

  /// The type of the sample.
  final SampleTypeId type;
}

/// A workout sample.
class Workout extends Sample {
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      uuid: json['uuid'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(
        ((json['startTimestamp'] as double) * 1000).toInt(),
      ),
      end: DateTime.fromMillisecondsSinceEpoch(
        ((json['endTimestamp'] as double) * 1000).toInt(),
      ),
      sourceRevision: SourceRevision.fromJson(Map.from(json['sourceRevision'])),
      device: json['device'] != null
          ? Device.fromJson(Map.from(json['device']))
          : null,
      workoutActivityType: WorkoutActivityType.values.firstWhereOrNull(
            (e) => e.code == json['workoutActivityType'],
          ) ??
          WorkoutActivityType.other,
      metadata: json['metadata'] != null ? Map.from(json['metadata']) : null,
      duration: Duration(seconds: (json['duration'] as double).toInt()),
    );
  }

  Workout({
    required super.uuid,
    required super.start,
    required super.end,
    required super.sourceRevision,
    required this.workoutActivityType,
    required this.duration,
    super.metadata,
    super.device,
    super.type = HKSampleTypeIdentifier.workout,
  });

  /// The type of workout.
  final WorkoutActivityType workoutActivityType;

  /// The duration of the workout.
  final Duration duration;
}

/// A quantity sample.
class Quantity extends Sample {
  factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        uuid: json['uuid'] as String,
        start: DateTime.fromMillisecondsSinceEpoch(
          ((json['startTimestamp'] as double) * 1000).toInt(),
        ),
        end: DateTime.fromMillisecondsSinceEpoch(
          ((json['endTimestamp'] as double) * 1000).toInt(),
        ),
        sourceRevision:
            SourceRevision.fromJson(Map.from(json['sourceRevision'])),
        device: json['device'] != null
            ? Device.fromJson(Map.from(json['device']))
            : null,
        metadata: json['metadata'] != null ? Map.from(json['metadata']) : null,
        type: HKQuantityTypeIdentifier.values.firstWhere(
          (e) => e.identifier == json['quantityType'],
        ),
        count: json['count'] as int,
        values: Map.from(json['values']),
      );

  Quantity({
    required super.uuid,
    required super.start,
    required super.end,
    required super.sourceRevision,
    required super.type,
    required this.count,
    required this.values,
    super.metadata,
    super.device,
  });

  /// The type of quantity.
  HKQuantityTypeIdentifier get quantityType => type as HKQuantityTypeIdentifier;

  /// The number of values.
  final int count;

  /// The values of the quantity.
  final Map<String, double> values;
}

/// An electrocardiogram sample.
class Electrocardiogram extends Sample {
  factory Electrocardiogram.fromJson(Map<String, dynamic> json) =>
      Electrocardiogram(
        uuid: json['uuid'] as String,
        start: DateTime.fromMillisecondsSinceEpoch(
          ((json['startTimestamp'] as double) * 1000).toInt(),
        ),
        end: DateTime.fromMillisecondsSinceEpoch(
          ((json['endTimestamp'] as double) * 1000).toInt(),
        ),
        sourceRevision:
            SourceRevision.fromJson(Map.from(json['sourceRevision'])),
        device: json['device'] != null
            ? Device.fromJson(Map.from(json['device']))
            : null,
        metadata: json['metadata'] != null ? Map.from(json['metadata']) : null,
        symptomsStatus: SymptomsStatus.values.firstWhere(
          (e) => e.code == json['symptomsStatus'],
        ),
        classification: Classification.values.firstWhere(
          (e) => e.code == json['classification'],
        ),
        numberOfVoltageMeasurements: json['numberOfVoltageMeasurements'] as int,
        averageHeartRate: json['averageHeartRate'] != null
            ? Map.from(json['averageHeartRate'])
            : null,
        samplingFrequency: json['samplingFrequency'] != null
            ? Map.from(json['samplingFrequency'])
            : null,
      );

  Electrocardiogram({
    required super.uuid,
    required super.start,
    required super.end,
    required super.sourceRevision,
    required this.numberOfVoltageMeasurements,
    required this.symptomsStatus,
    required this.classification,
    this.averageHeartRate,
    this.samplingFrequency,
    super.metadata,
    super.device,
    super.type = HKSampleTypeIdentifier.dataElectrocardiogram,
  });

  /// The number of voltage measurements.
  final int numberOfVoltageMeasurements;

  /// The symptoms status.
  final SymptomsStatus symptomsStatus;

  /// The classification of the electrocardiogram.
  final Classification classification;

  /// The average heart rate.
  final Map<String, double>? averageHeartRate;

  /// The sampling frequency.
  final Map<String, double>? samplingFrequency;
}

/// A correlation sample.
class Correlation extends Sample {
  factory Correlation.fromJson(Map<String, dynamic> json) {
    return Correlation(
      uuid: json['uuid'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(
        ((json['startTimestamp'] as double) * 1000).toInt(),
      ),
      end: DateTime.fromMillisecondsSinceEpoch(
        ((json['endTimestamp'] as double) * 1000).toInt(),
      ),
      type: HKCorrelationTypeIdentifier.values.firstWhere(
        (e) => e.identifier == json['correlationType'],
      ),
      sourceRevision: SourceRevision.fromJson(Map.from(json['sourceRevision'])),
      device: json['device'] != null
          ? Device.fromJson(Map.from(json['device']))
          : null,
      objects: (json['objects'] as List)
          .map((e) => Quantity.fromJson(Map.from(e)))
          .toList(),
      metadata: json['metadata'] != null ? Map.from(json['metadata']) : null,
    );
  }

  Correlation({
    required super.uuid,
    required super.start,
    required super.end,
    required super.sourceRevision,
    required this.objects,
    required super.type,
    super.metadata,
    super.device,
  });

  /// The type of correlation.
  final List<Quantity> objects;

  /// The objects of the correlation.
  HKCorrelationTypeIdentifier get correlationType =>
      type as HKCorrelationTypeIdentifier;
}

/// A source revision.
class SourceRevision {
  factory SourceRevision.fromJson(Map<String, dynamic> json) => SourceRevision(
        source: Source.fromJson(Map.from(json['source'])),
        version: json['version'],
        productType: json['productType'],
        operatingSystemVersion: OperatingSystemVersion.fromJson(
          Map.from(json['operatingSystemVersion']),
        ),
      );

  const SourceRevision({
    required this.source,
    required this.operatingSystemVersion,
    this.version,
    this.productType,
  });

  /// The source of the revision.
  final Source source;

  /// The version of the revision.
  final String? version;

  /// The product type of the revision.
  final String? productType;

  /// The operating system version of the revision.
  final OperatingSystemVersion operatingSystemVersion;

  /// The system version of the revision.
  String get systemVersion =>
      '${operatingSystemVersion.majorVersion}.${operatingSystemVersion.minorVersion}.${operatingSystemVersion.patchVersion}';

  Map<String, dynamic> toJson() => {
        'source': source.toJson(),
        'version': version,
        'productType': productType,
        'systemVersion': systemVersion,
        'operatingSystemVersion': operatingSystemVersion.toJson(),
      };
}

/// A device.
class Device {
  factory Device.fromJson(Map<String, dynamic> json) => Device(
        name: json['name'],
        manufacturer: json['manufacturer'],
        model: json['model'],
        hardware: json['hardwareVersion'],
        software: json['softwareVersion'],
      );

  const Device({
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.hardware,
    required this.software,
  });

  /// The name of the device.
  final String? name;

  /// The manufacturer of the device.
  final String? manufacturer;

  /// The model of the device.
  final String? model;

  /// The hardware version of the device.
  final String? hardware;

  /// The software version of the device.
  final String? software;

  Map<String, dynamic> toJson() => {
        'name': name,
        'manufacturer': manufacturer,
        'model': model,
        'hardwareVersion': hardware,
        'softwareVersion': software,
      };
}

/// A source.
class Source {
  factory Source.fromJson(Map<String, dynamic> json) => Source(
        name: json['name'],
        bundleIdentifier: json['bundleIdentifier'],
      );

  const Source({
    required this.name,
    required this.bundleIdentifier,
  });

  /// The name of the source.
  final String name;

  /// The bundle identifier of the source.
  final String bundleIdentifier;

  Map<String, dynamic> toJson() => {
        'name': name,
        'bundleIdentifier': bundleIdentifier,
      };
}

/// An operating system version.
class OperatingSystemVersion {
  factory OperatingSystemVersion.fromJson(Map<String, dynamic> json) =>
      OperatingSystemVersion(
        majorVersion: json['majorVersion'],
        minorVersion: json['minorVersion'],
        patchVersion: json['patchVersion'],
      );

  const OperatingSystemVersion({
    required this.majorVersion,
    required this.minorVersion,
    required this.patchVersion,
  });

  /// The major version of the operating system.
  final int majorVersion;

  /// The minor version of the operating system.
  final int minorVersion;

  /// The patch version of the operating system.
  final int patchVersion;

  Map<String, dynamic> toJson() => {
        'majorVersion': majorVersion,
        'minorVersion': minorVersion,
        'patchVersion': patchVersion,
      };
}

/// A workout activity type.
enum WorkoutActivityType {
  americanFootball._(1),
  archery._(2),
  australianFootball._(3),
  badminton._(4),
  baseball._(5),
  basketball._(6),
  bowling._(7),
  boxing._(8),
  climbing._(9),
  cricket._(10),
  crossTraining._(11),
  curling._(12),
  cycling._(13),
  dance._(14),
  danceInspiredTraining._(15),
  elliptical._(16),
  equestrianSports._(17),
  fencing._(18),
  fishing._(19),
  functionalStrengthTraining._(20),
  golf._(21),
  gymnastics._(22),
  handball._(23),
  hiking._(24),
  hockey._(25),
  hunting._(26),
  lacrosse._(27),
  martialArts._(28),
  mindAndBody._(29),
  mixedMetabolicCardioTraining._(30),
  paddleSports._(31),
  play._(32),
  preparationAndRecovery._(33),
  racquetball._(34),
  rowing._(35),
  rugby._(36),
  running._(37),
  sailing._(38),
  skatingSports._(39),
  snowSports._(40),
  soccer._(41),
  softball._(42),
  squash._(43),
  stairClimbing._(44),
  surfingSports._(45),
  swimming._(46),
  tableTennis._(47),
  tennis._(48),
  trackAndField._(49),
  traditionalStrengthTraining._(50),
  volleyball._(51),
  walking._(52),
  waterFitness._(53),
  waterPolo._(54),
  waterSports._(55),
  wrestling._(56),
  yoga._(57),
  barre._(58),
  coreTraining._(59),
  crossCountrySkiing._(60),
  downhillSkiing._(61),
  flexibility._(62),
  highIntensityIntervalTraining._(63),
  jumpRope._(64),
  kickboxing._(65),
  pilates._(66),
  snowboarding._(67),
  stairs._(68),
  stepTraining._(69),
  wheelchairWalkPace._(70),
  wheelchairRunPace._(71),
  taiChi._(72),
  mixedCardio._(73),
  handCycling._(74),
  discSports._(75),
  fitnessGaming._(76),
  cardioDance._(77),
  socialDance._(78),
  pickleball._(79),
  cooldown._(80),
  swimBikeRun._(82),
  transition._(83),
  underwaterDiving._(84),
  other._(3000);

  const WorkoutActivityType._(this.code);

  final int code;
}

/// Update frequency for background delivery.
enum UpdateFrequency {
  immediate._(1),
  hourly._(2),
  daily._(3),
  weekly._(4);

  const UpdateFrequency._(this.code);

  final int code;
}

/// Symptoms status.
enum SymptomsStatus {
  notSet._(0),
  none._(1),
  present._(2);

  const SymptomsStatus._(this.code);

  final int code;
}

/// Classification of an electrocardiogram.
enum Classification {
  notSet._(0),
  sinusRhythm._(1),
  atrialFibrillation._(2),
  inconclusiveLowHeartRate._(3),
  inconclusiveHighHeartRate._(4),
  inconclusivePoorReading._(5),
  inconclusiveOther._(6),
  unrecognized._(100);

  const Classification._(this.code);

  final int code;
}

enum HKStatisticsOptions {
  separateBySource._(1),
  discreteAverage._(2),
  discreteMin._(4),
  discreteMax._(8),
  cumulativeSum._(16),
  mostRecent._(32),
  duration._(64);

  const HKStatisticsOptions._(this.code);

  final int code;
}
