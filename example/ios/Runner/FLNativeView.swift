import Flutter
import UIKit

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
        print("arguments \(String(describing: args))")
        if let argument = args as? Dictionary<String,Any>{
            return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: argument["viewType"], binaryMessenger: messenger)
        }else {
            return FLNativeView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
        }
    }
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: FLView
    
    private var messenger: FlutterBinaryMessenger
    
    
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
        
    ) {
        _view = FLView()
        self.messenger = messenger
        
        super.init()
        self.createChannel( binaryMessenger: messenger)
        
    }
    
    func view() -> UIView {
        return _view
    }
    
    func createChannel(binaryMessenger messenger: FlutterBinaryMessenger){
        let channel = FlutterMethodChannel(name: "demo_plugin", binaryMessenger: messenger)
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
            case "moveToNaviteScreen":
                self.presentView()
                break
                
            default:
                break
            }
        })
    }
    
    
    func presentView(){
        let viewController = UIApplication.shared.keyWindow?.rootViewController
        
        let vc =  UIStoryboard.init(name: "UIStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "DemoViewController") as! DemoViewController
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
        
    }
    
    
}
