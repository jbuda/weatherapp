import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

      guard let flutterViewController  = window?.rootViewController as? FlutterViewController else {
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }

      let flutterChannel = FlutterMethodChannel.init(name: "webview", binaryMessenger: flutterViewController as! FlutterBinaryMessenger);
      flutterChannel.setMethodCallHandler { (flutterMethodCall, flutterResult) in
          if flutterMethodCall.method == "startNativeView" {

              let webView = WebViewController();
              webView.onCloseCallback = { [unowned self] in
                  self.window.rootViewController = nil
                  self.window.rootViewController = flutterViewController
              }

              if let arguments = flutterMethodCall.arguments as? [String: Any] {
                  webView.url = arguments["url"] as? String
              }

              self.window?.rootViewController = nil
              self.window = UIWindow(frame: UIScreen.main.bounds)
              self.window?.makeKeyAndVisible()
              self.window.rootViewController = webView
          }
      }

      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
