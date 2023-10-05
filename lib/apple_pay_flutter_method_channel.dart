import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'apple_pay_flutter_platform_interface.dart';

/// An implementation of [ApplePayFlutterPlatform] that uses method channels.
class MethodChannelApplePayFlutter extends ApplePayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('apple_pay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
