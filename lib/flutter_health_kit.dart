import 'flutter_health_kit_platform_interface.dart';
import 'models.dart';
import 'sort.dart';
import 'types.dart';

class FlutterHealthKit {
  static final mappers = <Type, dynamic Function(Map<dynamic, dynamic>)>{
    Workout: (map) => Workout.fromJson(Map.from(map)),
    Quantity: (map) => Quantity.fromJson(Map.from(map)),
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

  static Stream<ObjectTypeId> observeQuery(
    ObjectTypeId type, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return FlutterHealthKitPlatform.instance.observeQuery(
      type.identifier,
      startDate: startDate,
      endDate: endDate,
    ).map((event) => ObjectTypeId.fromIdentifier(event));
  }

  static Future<List<T>> querySampleType<T>(
    SampleTypeId type, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    Iterable<SortDescriptor>? sortDescriptors,
  }) async {
    final result = await FlutterHealthKitPlatform.instance.querySampleType(
      type.identifier,
      startDate: startDate,
      endDate: endDate,
      limit: limit,
      sortDescriptors: sortDescriptors?.map((e) => e.toJson()).toList(),
    );
    return result.map((e) => mappers[T]?.call(e)).whereType<T>().toList();
  }
}
