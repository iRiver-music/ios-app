import SwiftUI
import FirebaseCore
import GoogleSignIn
import LineSDK
import AVFoundation

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
    //要求背景播放
    init() {
           do {
               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
               try AVAudioSession.sharedInstance().setActive(true)
           } catch {
               print("Error setting audio session category:", error)
           }
       }
    
    let persistenceController = PersistenceController.shared

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
//            MainControl()
            MainView()
                .environmentObject(CurrentMusicData())
                .environmentObject(CurrentData())
        }
    }
}

