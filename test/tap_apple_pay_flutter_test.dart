import 'package:flutter_test/flutter_test.dart';
import 'package:tap_apple_pay_flutter/tap_apple_pay_flutter.dart';
import 'package:tap_apple_pay_flutter/tap_apple_pay_flutter_platform_interface.dart';
import 'package:tap_apple_pay_flutter/tap_apple_pay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTapApplePayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements TapApplePayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TapApplePayFlutterPlatform initialPlatform = TapApplePayFlutterPlatform.instance;

  test('$MethodChannelTapApplePayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTapApplePayFlutter>());
  });

  test('getPlatformVersion', () async {
    TapApplePayFlutter tapApplePayFlutterPlugin = TapApplePayFlutter();
    MockTapApplePayFlutterPlatform fakePlatform = MockTapApplePayFlutterPlatform();
    TapApplePayFlutterPlatform.instance = fakePlatform;

   // expect(await tapApplePayFlutterPlugin.getPlatformVersion(), '42');
  });
}
