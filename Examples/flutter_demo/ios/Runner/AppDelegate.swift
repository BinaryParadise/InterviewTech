import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GeneratedPluginRegistrant.register(with: self)
      
      if let fpr = registrar(forPlugin: "plugins.flutter.io/nano_platform_view_plugin") {
          let factory = NanoSegmentViewFactory(messenger: fpr.messenger())
          fpr.register(factory, withId: "plugins.flutter.io/nano_platform_view")
      }
      
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
