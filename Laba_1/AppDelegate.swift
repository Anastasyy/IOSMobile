import SwiftUI
import YandexMapsMobile

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        YMKMapKit.setApiKey("bbd78d68-51f7-4576-a12e-168dba36b020")
        YMKMapKit.sharedInstance()
        return true
    }
    
}
