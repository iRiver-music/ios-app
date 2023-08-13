////
////  iRiver_music_testApp.swift
////  iRiver-music-test
////
////  Created by laihungwei on 2023/6/30.
////
//
//import SwiftUI
//import AVFoundation
//
//@main
//struct iRiver_music_testApp: App {
//    //要求背景播放
//    init() {
//           do {
//               try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
//               try AVAudioSession.sharedInstance().setActive(true)
//           } catch {
//               print("Error setting audio session category:", error)
//           }
//       }
//
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//
//            MainView()
//                .environmentObject(CurrentMusicData())
//                .environmentObject(CurrentData())
////            ContentView()
////                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}
