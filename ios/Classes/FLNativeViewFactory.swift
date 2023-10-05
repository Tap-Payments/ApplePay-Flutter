import Flutter
import UIKit
import TapApplePayKit_iOS
import CommonDataModelsKit_iOS
import PassKit

class FLNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
   

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }

    /// Implementing this method is only necessary when the `arguments` in `createWithFrame` is not `nil`.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
          return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var _args: [String:Any]?

    public let myTapApplePayRequest:TapApplePayRequest = .init()
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
        
    ) {
      
        _view = UIView()
        self._args = args as? [String:Any]
        super.init()
       
        createNativeView(view: _view)
    }

    func view() -> UIView {
        return _view
    }
    
    var tapApplePayButton = TapApplePayButton.init()

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.clear
       
    
        
              
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)){
            self.tapApplePayButton = TapApplePayButton(frame: .init(x: 0, y: 0, width: self._view.frame.width, height: self._view.frame.height))
            var allowedNetworks:[TapApplePayPaymentNetwork] = []
            if let passedAllowedNetworks:[String] = self._args?["allowedCardNetworks"] as? [String] {
                
                  passedAllowedNetworks.forEach({ networkString in
                    if let networkEnum:TapApplePayPaymentNetwork = TapApplePayPaymentNetwork(rawValue: networkString.lowercased()) {
                      allowedNetworks.append(networkEnum)
                    }
                  })
                }
            
            var allowedCapabilities:PKMerchantCapability = []
            if let passedCapabilities:[String] = self._args?["merchantCapabilities"] as? [String] {
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
            
            self.myTapApplePayRequest.build(paymentNetworks: allowedNetworks, paymentItems: [], paymentAmount:self._args?["amount"] as? Double ?? 1, currencyCode: TapCurrencyCode(appleRawValue: self._args?["transactionCurrency"] as? String ?? "USD") ?? .USD,merchantID:self._args?["merchantId"] as? String ?? "merchant.tap.gosell", merchantCapabilities: allowedCapabilities)

            self.tapApplePayButton.setup(buttonType:TapApplePayButtonType(rawValue: self._args?["buttonType"] as? String ?? "plain") ?? .AppleLogoOnly)
            self.tapApplePayButton.dataSource = self
            self.tapApplePayButton.delegate   = self
            self._view.addSubview(self.tapApplePayButton)
            }

    }
}

// Implement the delegates and the data sources needed methods
extension FLNativeView:TapApplePayButtonDataSource,TapApplePayButtonDelegate {
  // You have to return the TapApplePayRequest which we defined up, to start the apple pay process
    var tapApplePayRequest: TapApplePayRequest {
        return myTapApplePayRequest
    }
    
    func tapApplePayValidationError(error: TapApplePayKit_iOS.TapApplePayRequestValidationError) {
    print("ERROR")
    }
    
    
    
    func tapApplePayFinished(with tapAppleToken: TapApplePayToken) {
        print("I can do whatever i want with the result token")
    }
}
