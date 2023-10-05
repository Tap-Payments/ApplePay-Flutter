import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'apple_pay_flutter_method_channel.dart';

abstract class ApplePayFlutterPlatform extends PlatformInterface {
  /// Constructs a ApplePayFlutterPlatform.
  ApplePayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ApplePayFlutterPlatform _instance = MethodChannelApplePayFlutter();

  /// The default instance of [ApplePayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelApplePayFlutter].
  static ApplePayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ApplePayFlutterPlatform] when
  /// they register themselves.
  static set instance(ApplePayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
