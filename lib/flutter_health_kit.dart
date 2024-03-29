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
  };

  static Future<bool> requestAuthorization({
    List<SampleTypeId>? toShare,
    List<ObjectTypeId>? read,
  }) {
    return FlutterHealthKitPlatform.instance.requestAuthorization(
      toShare: toShare?.map((e) => e.identifier).toList(),
      read: read?.map((e) => e.identifier).toList(),
    );
  }

  static Future<bool> enableBackgroundDelivery(
    ObjectTypeId type, [
    UpdateFrequency frequency = UpdateFrequency.hourly,
  ]) {
    return FlutterHealthKitPlatform.instance
        .enableBackgroundDelivery(type.identifier, frequency.code);
  }

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
}
