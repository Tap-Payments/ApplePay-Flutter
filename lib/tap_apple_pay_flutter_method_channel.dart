import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tap_apple_pay_flutter_platform_interface.dart';

/// An implementation of [TapApplePayFlutterPlatform] that uses method channels.
class MethodChannelTapApplePayFlutter extends TapApplePayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tap_apple_pay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
