import SwiftUI
import FirebaseCore
import GoogleSignIn
import LineSDK

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //google
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }
        //line
        if LoginManager.shared.application(app, open: url, options: options) {
            return true
        }
        // 其他可能的 URL 处理...
        return false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //firebase
        FirebaseApp.configure()
        //line SDK
        LoginManager.shared.setup(channelID: "1661190797", universalLinkURL: nil)
        return true
    }
}

@main
struct iRiverApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainControl()
        }
    }
}

