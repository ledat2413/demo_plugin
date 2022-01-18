import Flutter
import UIKit

public class SwiftDemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "demo_plugin", binaryMessenger: registrar.messenger())
    
    let instance = SwiftDemoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "getCountNumber":
   
    result(getCountNumber(args: call.arguments as! [Int]))
       
    default:
        result(nil)
    } 
  }

  public func getCountNumber(args: [Int]) -> Int {
    if (args != []){
       let result = args[0] + args[1]
    return result
    }else {
       return 0
    }
  }
}
