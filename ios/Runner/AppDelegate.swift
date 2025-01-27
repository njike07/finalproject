import Flutter
import UIKit


// new code 
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // new code 
    FlutterLocalNotificationsPlugins.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)}


    GeneratedPluginRegistrant.register(with: self)

    //new code 
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
