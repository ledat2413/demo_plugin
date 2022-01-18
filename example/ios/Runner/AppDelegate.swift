import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        weak var registrar = self.registrar(forPlugin: "flutter-plugin")
        
        let factory = FLNativeViewFactory(messenger: registrar!.messenger())
        self.registrar(forPlugin: "<flutter-plugin>")!.register(
            factory,
            withId: "native-view")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
