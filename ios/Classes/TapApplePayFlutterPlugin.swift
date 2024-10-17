import Flutter
import UIKit
import TapApplePayKit_iOS
import CommonDataModelsKit_iOS
import PassKit

public class TapApplePayFlutterPlugin: NSObject, FlutterPlugin {
   public static func register(with registrar: FlutterPluginRegistrar) {
         let factory = FLNativeViewFactory(messenger: registrar.messenger())
         registrar.register(factory, withId: "apple-pay-flutter-view")

         let channel = FlutterMethodChannel(name: "apple_pay_flutter", binaryMessenger: registrar.messenger())

         let instance = TapApplePayFlutterPlugin()
         registrar.addMethodCallDelegate(instance, channel: channel)

   }

  let tapApplePay:TapApplePay = .init()

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       let argumentsDictionary:[String: Any]? = call.arguments as? [String: Any]
     // let buttonType = argumentsDictionary["buttonType"] as? String
     // let buttonStyle = argumentsDictionary["buttonStyle"] as? String

       print("method calls")
       switch call.method {
       case "setupApplePay":
         TapApplePay.sdkMode = .sandbox
         if(argumentsDictionary?["environmentMode"] as? String == "production"){
             TapApplePay.sdkMode = .production
         }

         TapApplePay.setupTapMerchantApplePay(merchantKey:
                                                SecretKey.init(sandbox: argumentsDictionary?["sandboxKey"] as? String ?? "",
                                                                          production: argumentsDictionary?["productionKey"] as? String ?? ""),
                                              merchantID: argumentsDictionary?["merchantId"] as? String ?? "merchant.tap.gosell") {

             result(["success":true,"data":""])
             } onErrorOccured: { error in

               result(["success":false, "error":"\(error ?? "")"])
             }

       case "generateApplePayToken":
           tapApplePay.authorizePayment(for: generateApplePayRequest(with: argumentsDictionary)) { [weak self] (token) in
               result(["success":true,"data":token.stringAppleToken ?? ""])

               } onErrorOccured: { error in
                   result(["success":false,"error":error.TapApplePayRequestValidationErrorRawValue()])

               }


       case "generateTapApplePayToken":

           tapApplePay.authorizePayment(for: generateApplePayRequest(with: argumentsDictionary)) { [weak self] (token) in

               self?.tapApplePay.createTapToken(for: token, onTokenReady: { tapToken in

                   var resultMap:[String:Any] = [:]
                   resultMap["token"] = tapToken.identifier
                   resultMap["token_currency"] = argumentsDictionary?["transactionCurrency"] as? String ?? "USD"
                   resultMap["issuer_bank"] = tapToken.card.issuer?.bank ?? ""
                   resultMap["issuer_country"] = tapToken.card.issuer?.country ?? ""
                   resultMap["issuer_id"] = tapToken.card.issuer?.id ?? ""

                   resultMap["card_first_six"] = tapToken.card.binNumber
                   resultMap["card_last_four"] = tapToken.card.lastFourDigits
                   resultMap["card_object"] = tapToken.card.object
                   resultMap["card_exp_month"] = tapToken.card.expirationMonth
                   resultMap["card_exp_year"] = tapToken.card.expirationYear
                   resultMap["sdk_result"] = "SUCCESS"
                   resultMap["trx_mode"] = "TOKENIZE"

                   result(["success":true,"data":resultMap])
                       }, onErrorOccured: { (session, result1, error) in

                           result(["success":false,"error":error.debugDescription])

                       })

               } onErrorOccured: { error in
                   result(["success":false,"error":error.TapApplePayRequestValidationErrorRawValue()])
               }


     default:
       result(FlutterMethodNotImplemented)
     }
   }

     func generateApplePayRequest(with argumentsDictionary:[String:Any]?) -> TapApplePayRequest {

         let myTapApplePayRequest:TapApplePayRequest = .init()

         var allowedNetworks:[TapApplePayPaymentNetwork] = []
         if let passedAllowedNetworks:[String] = argumentsDictionary?["allowedCardNetworks"] as? [String] {

               passedAllowedNetworks.forEach({ networkString in
                 if let networkEnum:TapApplePayPaymentNetwork = TapApplePayPaymentNetwork(rawValue: networkString.lowercased()) {
                   allowedNetworks.append(networkEnum)
                 }
               })
             }

         var allowedCapabilities:PKMerchantCapability = []
         if let passedCapabilities:[String] = argumentsDictionary?["merchantCapabilities"] as? [String] {
               passedCapabilities.forEach({ capabilityString in
                 if capabilityString.lowercased() == "threeds" {
                   allowedCapabilities.insert(.threeDSecure)
                 }else if capabilityString.lowercased() == "credit" {
                   allowedCapabilities.insert(.credit)
                 }else if capabilityString.lowercased() == "debit" {
                   allowedCapabilities.insert(.debit)
                 }
               })
             }

         myTapApplePayRequest.build(paymentNetworks: allowedNetworks,
                                    paymentItems: [],
                                    paymentAmount: argumentsDictionary?["amount"] as? Double ?? 1,
                                    currencyCode: TapCurrencyCode(appleRawValue: argumentsDictionary?["transactionCurrency"] as? String ?? "USD") ?? .USD,
                                    applePayMerchantID: argumentsDictionary?["applePayMerchantId"] as? String ?? "",
                                    merchantCapabilities: allowedCapabilities)

         return myTapApplePayRequest

       }
}
