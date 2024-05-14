# ApplePay-Flutter

A flutter sdk provided by [Tap Payments](https://tap.company), to accept Apple Pay payments within your Flutter applications.


[![Pub](https://camo.githubusercontent.com/8cd9770d1a75643cbdc23e2e6f60a3474264f029ee1e7cf6445278aea0e500e8/68747470733a2f2f696d672e736869656c64732e696f2f7075622f762f666c75747465725f7374616767657265645f677269645f766965772e737667)](https://pub.dartlang.org/packages/tap_apple_pay_flutter)

## Getting started

In the  `pubspec.yaml`  of your flutter project, add the following dependency:

dependencies:
```dart
  tap_apple_pay_flutter: 1.0.2
```
In your library add the following import:
```dart
import 'package:tap_apple_pay_flutter/models/models.dart';
```

Then execute this in flutter terminal:
```
cd ios
pod install
pod update
```

## Minimum requirements
1. Dart version 3.0.0 +
2. Flutter version 3.0.0 +
3. iOS 13.0 +

## SDK response format
Through out, the interaction of your app with Tap Apple Pay SDK, we made sure you will get the same response format to ease the parsing process your end.
The format will always be as follows:

 1. Success case:
	 2. `{'success':true,'data':''}`
		 3. So when success is true, this means the process is completed successfully.
		 4. data is an optional object, will pass back any data expected as a result of the performed action.
 2. Error case:
	 3. `{'success':false,'error':''}`
		 4. So when success is false, this means the process failed.
		 5. error is a string that will identify which error did occur.

  
## Pre rendering setup 

A setup is needed to be done, before rendering the Apple Pay widget. These configurations, will define to the Apple Pay widget the data required for tokenization & styling afterwards. Following is a code snippet example, of how to setup Apple Pay widget.

```dart
Future<void> setupApplePay(
		// This is the testing key, provided upon registering your bundle id in Tap
      {String sandboxKey = "pk_test_Vlk842......",
	    // This is the production key, provided upon registering your bundle id in Tap
      String productionKey = "pk_live_UYnihb.....",
      // This is the sdk mode enum, defines the environment your application is running in.
      // Accepted values are : SdkMode.sandbox / SdkMode.production
      required SdkMode sdkMode}) async {
      // Store your data in our plugin level
    TapApplePayFlutter.setupApplePayConfiguration(
      sandboxKey: sandboxKey,
      productionKey: productionKey,
      sdkMode: sdkMode,
    );
    try {
	  // Now we call a public interface provided by Apple pay flutter sdk.
	  // It is of type future, and the response will follow the structure described before.
      var result = await TapApplePayFlutter.setupApplePay;
      if(result["success"]) {
	      debugPrint("Apple pay plugin is configured properly.");
      }else{
	      debugPrint("Apple pay plugin configuration failed : $result["error"]");      
      }
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }
```

Then from your code anywhere **before rendering** the widget call it like it this:
```dart
setupApplePay(
	sandboxKey: "",
	productionKey: "",
	sdkMode: widget.sdkMode,
);
```

## Adding the Apple Pay widget

Within your widget hierarchy, you can add our Apple Pay widget as normally as you do with native provided widgets. A sample is as follows:
```dart
TapApplePayFlutter.buildApplePayButton( // The button widget
  applePayButtonType: ApplePayButtonType.appleLogoOnly, // Defines the type of apple pay button. it is one of the provided values by [Apple](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaybuttontype)
  applePayButtonStyle: ApplePayButtonStyle.black,
  onPress: () { // This will be fired once the widget is clicked Optional.
    getApplePayToken(); // A sample code below to show how to generate a raw apple pay token
    getTapTokenToken(); // A sample code below to show how to generate a Tap token that can be used to charge the customer through Tap apis.
  },
)
```


## Generating Apple Pay token

You can ask our plugin to authorize a payment from Apple Pay system, and provide you back with the raw Apple Pay token for your own further usages. Make sure you already called the `setup` process we indicated above before calling this interface.
A sample code to generate the Apple Pay token is as follows:
```dart
/// A sample function simulating how can you ask our plugin to generate a raw apple pay token
Future<void> getApplePayToken() async {
    try {
	// our interface is of future type.
      var result = await TapApplePayFlutter.getApplePayToken(
        config: ApplePayConfig(
          transactionCurrency: TapCurrencyCode.SAR, // A 3 iso digits currency code. We have created a list of enums to prevent typos.
          allowedCardNetworks: [ // Define the list of allowed card schemes for your customer to pay with
            AllowedCardNetworks.AMEX,
            AllowedCardNetworks.VISA,
            AllowedCardNetworks.MASTERCARD,
          ],
          applePayMerchantId: "merchant.tap.gosell", // This is the apple pay merchant id you created and linked with your apple pay certificate from within your apple pay developer account
          amount: 1.0, // The total amount
          merchantCapabilities: [ // The allowed card funding sources your customer can pay with
            MerchantCapabilities.ThreeDS,
            MerchantCapabilities.Debit,
            MerchantCapabilities.Credit,
          ],
        ),
      );
	  
	  if(result["success"]) {
	      debugPrint("Result of Apple Pay Token >>>>>>> $result");
	   }else{
		  debugPrint("Error of Apple Pay Token >>>>>>> $result"); 
	   }
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }
```



## Generating Tap Apple Pay token

You can ask our plugin to authorize a payment from Apple Pay system, and then generate a Tap token for it. By that token, you can perform a charge through our [APIS](https://developers.tap.company/reference/create-a-charge). Make sure you already called the `setup` process we indicated above before calling this interface.
A sample code to generate the Tap Apple Pay token is as follows:
```dart
/// A sample function simulating how can you ask our plugin to generate a tap apple pay token
Future<void> getTapTokenToken() async {
    try {
	// our interface is of future type.
      var result = await TapApplePayFlutter.getTapToken(
        config: ApplePayConfig(
          transactionCurrency: TapCurrencyCode.SAR, // A 3 iso digits currency code. We have created a list of enums to prevent typos.
          allowedCardNetworks: [ // Define the list of allowed card schemes for your customer to pay with
            AllowedCardNetworks.AMEX,
            AllowedCardNetworks.VISA,
            AllowedCardNetworks.MASTERCARD,
          ],
          applePayMerchantId: "merchant.tap.gosell", // This is the apple pay merchant id you created and linked with your apple pay certificate from within your apple pay developer account
          amount: 1.0, // The total amount
          merchantCapabilities: [ // The allowed card funding sources your customer can pay with
            MerchantCapabilities.ThreeDS,
            MerchantCapabilities.Debit,
            MerchantCapabilities.Credit,
          ],
        ),
      );
	  
	  if(result["success"]) {
	      debugPrint("Result of Tap Apple Pay Token >>>>>>> $result");
	   }else{
		  debugPrint("Error of Tap Apple Pay Token >>>>>>> $result"); 
	   }
    } catch (ex) {
      debugPrint("Error >>>>>>> $ex");
    }
  }
```


## Xcode needed setup
You will need to add Apple Pay as a capability inside your project's settings in Xcode. And select the Apple Pay merchant id you are passing to our plugin.

![enter image description here](https://i.ibb.co/DgWBzWK/Screenshot-2023-10-05-at-5-52-25-PM.jpg)


## Integration needed steps:
1. Onboard with Tap at [Tap Payments](https://tap.company)
2. Register your bundle id.
3. Ask for Apple Pay CSR from our integration team.
4. Go to your Apple Pay developer account [Certificates](https://developer.apple.com/account/resources/certificates/list)
5. Click on `Add certificate` ![enter image description here](https://i.ibb.co/wpV3Vvg/Screenshot-2023-10-05-at-5-56-21-PM.png)
6. Choose Apple Pay payment processing certificate![enter image description here](https://i.ibb.co/JBkD6qH/Screenshot-2023-10-05-at-5-56-32-PM.png) 
7. Select the Apple Pay merchant id. Make sure, it is the one you will pass inside the Xcode ![enter image description here](https://i.ibb.co/6v1X7F5/Screenshot-2023-10-05-at-5-56-43-PM.png)
8. Upload the CSR you got from Tap team.
9. Download the Apple Pay certificate and share it back to the Tap team ![enter image description here](https://i.ibb.co/SsCG3my/Screenshot-2023-10-05-at-5-57-09-PM.png)
