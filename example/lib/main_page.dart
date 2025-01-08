import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_apple_pay_flutter/models/models.dart';

import 'package:tap_apple_pay_flutter/tap_apple_pay_flutter.dart';

enum TokenType { applePayToken, tapToken }

class MainPage extends StatefulWidget {
  final SdkMode sdkMode;

  const MainPage({
    super.key,
    required this.sdkMode,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController amountController = TextEditingController();

  List<TapCurrencyCode> currencyList = [
    TapCurrencyCode.SAR,
    TapCurrencyCode.USD,
    TapCurrencyCode.KWD,
    TapCurrencyCode.BHD,
  ];

  TapCurrencyCode selectedCurrencyCode = TapCurrencyCode.SAR;
  TokenType tokenType = TokenType.applePayToken;

  @override
  void initState() {
    super.initState();
    setupApplePay(
      sdkMode: widget.sdkMode,
    );
  }

  dynamic responseData;

  bool loading = false;

  Future<void> setupApplePay({
    String sandboxKey = "pk_test_Vlk842B1EA7tDN5Qbr*****",
    String productionKey = "pk_live_UYnihb8dtBXm9fDSw1k*****",
    required SdkMode sdkMode,
  }) async {
    TapApplePayFlutter.setupApplePayConfiguration(
      sandboxKey: sandboxKey,
      productionKey: productionKey,
      sdkMode: widget.sdkMode,
      merchantId: '',
    );
    try {
      setState(() {
        loading = true;
      });
      var result = await TapApplePayFlutter.setupApplePay;

      debugPrint("Setup apple pay result >>> $result");
      setState(() {
        loading = false;
      });
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }

  Future<void> getApplePayToken() async {
    try {
      var result = await TapApplePayFlutter.getApplePayToken(
        config: ApplePayConfig(
          transactionCurrency: selectedCurrencyCode,
          allowedCardNetworks: [
            AllowedCardNetworks.AMEX,
            AllowedCardNetworks.VISA,
            AllowedCardNetworks.MASTERCARD,
          ],
          applePayMerchantId: "merchant.tap.gosell",
          amount: amountController.text.isEmpty
              ? 111
              : double.parse(amountController.text),
          merchantCapabilities: [
            MerchantCapabilities.ThreeDS,
            MerchantCapabilities.Debit,
            MerchantCapabilities.Credit,
            MerchantCapabilities.EMV,
          ],
        ),
      );

      debugPrint("Result of Apple Pay Token >>>>>>> $result");
      setState(() {
        responseData = result;
      });
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }

  Future<void> getTapToken() async {
    try {
      var result = await TapApplePayFlutter.getTapToken(
        config: ApplePayConfig(
          transactionCurrency: selectedCurrencyCode,
          allowedCardNetworks: [
            AllowedCardNetworks.AMEX,
            AllowedCardNetworks.VISA,
            AllowedCardNetworks.MASTERCARD,
          ],
          applePayMerchantId: "merchant.tap.gosell",
          amount: amountController.text.isEmpty
              ? 111
              : double.parse(amountController.text),
          merchantCapabilities: [
            MerchantCapabilities.ThreeDS,
            MerchantCapabilities.Debit,
            MerchantCapabilities.Credit,
            MerchantCapabilities.EMV,
          ],
        ),
      );
      debugPrint("Result of Tap Token >>>>>>> $result");
      setState(() {
        responseData = result;
      });
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: amountController,
                  onChanged: (String? value) {
                    if (value!.isNotEmpty) {
                      setState(() {
                        amountController.text = value;
                      });
                    } else {
                      setState(() {
                        amountController.clear();
                      });
                    }
                  },
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                      RegExp(r"[0-9.]"),
                    ),
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    labelText: "Amount",
                    hintText: "Enter Amount",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: DropdownButton<TapCurrencyCode>(
                    items: currencyList.map((TapCurrencyCode value) {
                      return DropdownMenuItem<TapCurrencyCode>(
                        value: value,
                        child: Text(value.name),
                      );
                    }).toList(),
                    value: selectedCurrencyCode,
                    onChanged: (TapCurrencyCode? value) {
                      setState(() {
                        selectedCurrencyCode = value!;
                      });
                    },
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: SegmentedButton<TokenType>(
                  segments: const <ButtonSegment<TokenType>>[
                    ButtonSegment<TokenType>(
                      value: TokenType.applePayToken,
                      label: Text(
                        'Generate Apple Pay Token',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    ButtonSegment<TokenType>(
                      value: TokenType.tapToken,
                      label: Text(
                        'Generate Tap Token',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  selected: <TokenType>{tokenType},
                  onSelectionChanged: (Set<TokenType> newSelection) {
                    setState(() {
                      tokenType = newSelection.first;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              loading
                  ? const CupertinoActivityIndicator()
                  : TapApplePayFlutter.buildApplePayButton(
                      applePayButtonType: ApplePayButtonType.appleLogoOnly,
                      applePayButtonStyle: ApplePayButtonStyle.black,
                      onPress: () {
                        if (tokenType == TokenType.tapToken) {
                          getTapToken();
                        } else {
                          getApplePayToken();
                        }
                      },
                    ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Response : ${responseData ?? ""}"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
