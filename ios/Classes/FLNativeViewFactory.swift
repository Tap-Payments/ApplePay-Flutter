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
           
            self.tapApplePayButton.setup(buttonType:TapApplePayButtonType(rawValue: self._args?["buttonType"] as? String ?? "plain") ?? .AppleLogoOnly,buttonStyle: .init(rawValue: self._args?["buttonStyle"] as? String ?? "black") ?? .Black)
           
            self._view.addSubview(self.tapApplePayButton)
            }

    }
}
