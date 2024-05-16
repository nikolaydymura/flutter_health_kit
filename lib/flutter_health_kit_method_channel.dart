import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_health_kit_platform_interface.dart';

/// An implementation of [FlutterHealthKitPlatform] that uses method channels.
class MethodChannelFlutterHealthKit extends FlutterHealthKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_health_kit');

  @override
  Future<bool> requestAuthorization({
    List<String>? toShare,
    List<String>? read,
  }) async {
    final result =
        await methodChannel.invokeMethod<bool>('requestAuthorization', {
      if (toShare != null && toShare.isNotEmpty) 'toShare': toShare,
      if (read != null && read.isNotEmpty) 'read': read,
    });
    return result ?? false;
  }

  @override
  Future<bool> enableBackgroundDelivery(String type, int frequency) async {
    final result =
        await methodChannel.invokeMethod<bool>('enableBackgroundDelivery', {
      'type': type,
      'frequency': frequency,
    });
    return result ?? false;
  }

  @override
  Future<Stream<String>> observeQuery(
    String type, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final channelId =
        await methodChannel.invokeMethod<String>('observeQuery', type);

    if (channelId == null) {
      throw Exception('Failed to create event channel');
    }

    return EventChannel(channelId).receiveBroadcastStream({
      if (startDate != null) 'startDate': startDate.millisecondsSinceEpoch,
      if (endDate != null) 'endDate': endDate.millisecondsSinceEpoch,
    }).map((e) => e as String);
  }

  @override
  Future<List<Map<dynamic, dynamic>>> querySampleType(
    String type, {
    int? limit,
    Map<String, dynamic>? predicate,
    Iterable<Map<String, dynamic>>? sortDescriptors,
  }) async {
    final result = await methodChannel.invokeListMethod<Map<dynamic, dynamic>>(
        'querySampleType', <String, dynamic>{
      'sampleType': type,
      if (limit != null && limit != 0) 'limit': limit,
      if (predicate != null && predicate.isNotEmpty) 'predicate': predicate,
      if (sortDescriptors != null && sortDescriptors.isNotEmpty)
        'sortDescriptors': sortDescriptors,
    });
    return result ?? [];
  }

  @override
  Future<List<Map<dynamic, dynamic>>> queryStatistics(
    String type, {
    Map<String, dynamic>? predicate,
    Iterable<int>? options,
  }) async {
    final result = await methodChannel.invokeListMethod<Map<dynamic, dynamic>>(
        'queryStatistics', <String, dynamic>{
      'quantityType': type,
      if (predicate != null && predicate.isNotEmpty) 'predicate': predicate,
      if (options != null && options.isNotEmpty) 'options': options,
    });
    return result ?? [];
  }

  @override
  Future<List<Map<dynamic, dynamic>>> queryElectrocardiogram(
    String uuid,
  ) async {
    final result = await methodChannel.invokeListMethod<Map<dynamic, dynamic>>(
      'queryElectrocardiogram',
      uuid,
    );
    return result ?? [];
  }
}
