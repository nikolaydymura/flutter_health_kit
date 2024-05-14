import 'flutter_health_kit_platform_interface.dart';
import 'models.dart';
import 'predicate.dart';
import 'sort.dart';
import 'types.dart';

class FlutterHealthKit {
  static final mappers = <Type, dynamic Function(Map<dynamic, dynamic>)>{
    Workout: (map) => Workout.fromJson(Map.from(map)),
    Quantity: (map) => Quantity.fromJson(Map.from(map)),
    Correlation: (map) => Correlation.fromJson(Map.from(map)),
    Electrocardiogram: (map) => Electrocardiogram.fromJson(Map.from(map)),
  };

  /// Requests authorization to access health data.
  ///
  /// [toShare] is a list of [SampleTypeId] that the app wants to write data to.
  /// [read] is a list of [ObjectTypeId] that the app wants to read data from.
  static Future<bool> requestAuthorization({
    List<SampleTypeId>? toShare,
    List<ObjectTypeId>? read,
  }) {
    return FlutterHealthKitPlatform.instance.requestAuthorization(
      toShare: toShare?.map((e) => e.identifier).toList(),
      read: read?.map((e) => e.identifier).toList(),
    );
  }

  /// Enables background delivery of health data.
  ///
  /// [type] is the [ObjectTypeId] to enable background delivery for.
  /// [frequency] is the [UpdateFrequency] to deliver the data.
  static Future<bool> enableBackgroundDelivery(
    ObjectTypeId type, [
    UpdateFrequency frequency = UpdateFrequency.hourly,
  ]) {
    return FlutterHealthKitPlatform.instance
        .enableBackgroundDelivery(type.identifier, frequency.code);
  }

  /// Queries health data.
  ///
  /// [type] is the [ObjectTypeId] to query.
  /// [startDate] is the start date of the query.
  /// [endDate] is the end date of the query.
  static Future<Stream<ObjectTypeId>> observeQuery(
    ObjectTypeId type, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final stream = await FlutterHealthKitPlatform.instance.observeQuery(
      type.identifier,
      startDate: startDate,
      endDate: endDate,
    );
    return stream.map((event) => ObjectTypeId.fromIdentifier(event));
  }

  /// Queries health data.
  ///
  /// [type] is the [SampleTypeId] to query.
  /// [limit] is the maximum number of samples to return.
  /// [predicate] is a [PredicateDescriptor] to filter the samples.
  /// [sortDescriptors] is a list of [SortDescriptor] to sort the samples.
  static Future<List<T>> querySampleType<T extends Sample>(
    SampleTypeId type, {
    int? limit,
    PredicateDescriptor? predicate,
    Iterable<SortDescriptor>? sortDescriptors,
  }) async {
    final result = await FlutterHealthKitPlatform.instance.querySampleType(
      type.identifier,
      limit: limit,
      predicate: predicate,
      sortDescriptors: sortDescriptors?.map((e) => e.toJson()).toList(),
    );
    return result.map((e) => mappers[T]?.call(e)).whereType<T>().toList();
  }

  static Future<List<T>> queryStatistics<T extends Sample>(
    HKQuantityTypeIdentifier type, {
    PredicateDescriptor? predicate,
    Iterable<HKStatisticsOptions>? options,
  }) async {
    final result = await FlutterHealthKitPlatform.instance.queryStatistics(
      type.identifier,
      predicate: predicate,
      options: options?.map((e) => e.code).toList(),
    );
    return result.map((e) => mappers[T]?.call(e)).whereType<T>().toList();
  }
}
