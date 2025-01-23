import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/models.dart';

class TapApplePayFlutter {
  static const MethodChannel _channel = MethodChannel('apple_pay_flutter');

  static Future<dynamic> get setupApplePay async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      throw Exception('Not available for Android');
    }

    try {
      dynamic result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'setupApplePay',
        _setupApplePayConfiguration,
      );
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getApplePayToken({
    required ApplePayConfig config,
  }) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      throw Exception('Not available for Android');
    }
    try {
      dynamic result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'generateApplePayToken',
        {
          "transactionCurrency": config.transactionCurrency.name,
          "allowedCardNetworks":
              config.allowedCardNetworks.map((e) => e.name).toList(),
          "applePayMerchantId": config.applePayMerchantId,
          "amount": config.amount,
          "merchantCapabilities":
              config.merchantCapabilities.map((e) => e.name).toList()
        },
      );
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getTapToken({required ApplePayConfig config}) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      throw Exception('Not available for Android');
    }

    try {
      dynamic result = await _channel.invokeMethod<Map<Object?, Object?>>(
        'generateTapApplePayToken',
        {
          "transactionCurrency": config.transactionCurrency.name,
          "allowedCardNetworks":
              config.allowedCardNetworks.map((e) => e.name).toList(),
          "applePayMerchantId": config.applePayMerchantId,
          "amount": config.amount,
          "merchantCapabilities":
              config.merchantCapabilities.map((e) => e.name).toList()
        },
      );
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static late Map<String, dynamic> _setupApplePayConfiguration;

  /// App configurations
  static void setupApplePayConfiguration({
    required String sandboxKey,
    required String productionKey,
    required SdkMode sdkMode,
    required String? merchantId,
  }) {
    _setupApplePayConfiguration = {
      "sandboxKey": sandboxKey,
      "productionKey": productionKey,
      "environmentMode": sdkMode.name,
      "merchantId": merchantId ?? "",
    };
  }

  static Widget buildApplePayButton({
    required ApplePayButtonType applePayButtonType,
    required ApplePayButtonStyle applePayButtonStyle,
    required Function()? onPress,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container();
    }

    return SizedBox(
      height: 45,
      child: Stack(
        children: [
          _ApplePayFlutter(
            applePayButtonType: applePayButtonType,
            applePayButtonStyle: applePayButtonStyle,
          ),
          SizedBox(
            height: 50,
            child: InkWell(
              onTap: onPress,
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplePayFlutter extends StatefulWidget {
  final ApplePayButtonType applePayButtonType;
  final ApplePayButtonStyle applePayButtonStyle;

  const _ApplePayFlutter({
    super.key,
    required this.applePayButtonType,
    required this.applePayButtonStyle,
  });

  @override
  State<_ApplePayFlutter> createState() => _ApplePayFlutterState();
}

class _ApplePayFlutterState extends State<_ApplePayFlutter> {
  Key _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return Container();
    }

    String buttonType;

    switch (widget.applePayButtonType) {
      case ApplePayButtonType.appleLogoOnly:
        buttonType = "plain";
        break;
      case ApplePayButtonType.bookWithApplePay:
        buttonType = "book";
        break;
      case ApplePayButtonType.buyWithApplePay:
        buttonType = "buy";
        break;
      case ApplePayButtonType.checkoutWithApplePay:
        buttonType = "checkout";
        break;
      case ApplePayButtonType.donateWithApplePay:
        buttonType = "donate";
        break;
      case ApplePayButtonType.payWithApplePay:
        buttonType = "pay";
        break;
      case ApplePayButtonType.setupApplePay:
        buttonType = "setup";
        break;
      case ApplePayButtonType.subscribeWithApplePay:
        buttonType = "subscribe";
        break;
      default:
        buttonType = "plain";
    }
    setState(() {
      _refreshKey = UniqueKey();
    });

    return UiKitView(
      key: _refreshKey,
      viewType: 'apple-pay-flutter-view',
      creationParams: {
        'buttonType': buttonType,
        'buttonStyle': widget.applePayButtonStyle.name,
      },
      layoutDirection: TextDirection.ltr,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
