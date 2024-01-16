import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_health_kit_method_channel.dart';

abstract class FlutterHealthKitPlatform extends PlatformInterface {
  /// Constructs a FlutterHealthKitPlatform.
  FlutterHealthKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterHealthKitPlatform _instance = MethodChannelFlutterHealthKit();

  /// The default instance of [FlutterHealthKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterHealthKit].
  static FlutterHealthKitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterHealthKitPlatform] when
  /// they register themselves.
  static set instance(FlutterHealthKitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> requestAuthorization({
    List<String>? toShare,
    List<String>? read,
  }) {
    throw UnimplementedError(
      'requestAuthorization() has not been implemented.',
    );
  }

  Future<bool> enableBackgroundDelivery(String type, int frequency) {
    throw UnimplementedError(
      'enableBackgroundDelivery() has not been implemented.',
    );
  }

  Future<List<Map<dynamic, dynamic>>> querySampleType(
    String type, {
    int? limit,
    Map<String, dynamic>? predicate,
    Iterable<Map<String, dynamic>>? sortDescriptors,
  }) {
    throw UnimplementedError('querySampleType() has not been implemented.');
  }

  Future<Stream<String>> observeQuery(
    String type, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    throw UnimplementedError('observeQuery() has not been implemented.');
  }
}
