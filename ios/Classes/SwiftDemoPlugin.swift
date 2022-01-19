import Flutter
import UIKit

public class SwiftDemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "demo_plugin", binaryMessenger: registrar.messenger())
    
    let instance = SwiftDemoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

   
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

    switch call.method {
    case "getCountNumber":
   
    if let args = call.arguments{
        let numb = getCountNumber(args: args as! [Int])
        result(numb)
      }
    default:
        result(nil)
      } 
    })
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "getCountNumber":
        result(0)
    default:
        result(nil)
    } 
  }


  public func getCountNumber(args: [Int]) -> Int {
    if (args.count != 0){
       let result = args[0] + args[1]
    return result
    }else {
    return 0
    }
  }
}
