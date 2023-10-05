import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tap_apple_pay_flutter_method_channel.dart';

abstract class TapApplePayFlutterPlatform extends PlatformInterface {
  /// Constructs a TapApplePayFlutterPlatform.
  TapApplePayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TapApplePayFlutterPlatform _instance = MethodChannelTapApplePayFlutter();

  /// The default instance of [TapApplePayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTapApplePayFlutter].
  static TapApplePayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TapApplePayFlutterPlatform] when
  /// they register themselves.
  static set instance(TapApplePayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
