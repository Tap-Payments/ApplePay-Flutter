import 'package:flutter_test/flutter_test.dart';
import 'package:apple_pay_flutter/apple_pay_flutter.dart';
import 'package:apple_pay_flutter/apple_pay_flutter_platform_interface.dart';
import 'package:apple_pay_flutter/apple_pay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockApplePayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements ApplePayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ApplePayFlutterPlatform initialPlatform = ApplePayFlutterPlatform.instance;

  test('$MethodChannelApplePayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelApplePayFlutter>());
  });

  test('getPlatformVersion', () async {
    ApplePayFlutter applePayFlutterPlugin = ApplePayFlutter();
    MockApplePayFlutterPlatform fakePlatform = MockApplePayFlutterPlatform();
    ApplePayFlutterPlatform.instance = fakePlatform;

   // expect(await applePayFlutterPlugin.getPlatformVersion(), '42');
  });
}
