import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_health_kit/flutter_health_kit.dart';
import 'package:flutter_health_kit/flutter_health_kit_platform_interface.dart';
import 'package:flutter_health_kit/flutter_health_kit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterHealthKitPlatform
    with MockPlatformInterfaceMixin
    implements FlutterHealthKitPlatform {
  @override
  Future<bool> requestAuthorization({
    List<String>? toShare,
    List<String>? read,
  }) async =>
      true;

  @override
  noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  final initialPlatform = FlutterHealthKitPlatform.instance;

  test('$MethodChannelFlutterHealthKit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterHealthKit>());
  });

  test('requestAuthorization', () async {
    final fakePlatform = MockFlutterHealthKitPlatform();
    FlutterHealthKitPlatform.instance = fakePlatform;

    expect(await FlutterHealthKit.requestAuthorization(), true);
  });
}
