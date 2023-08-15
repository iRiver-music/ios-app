////
////  UserSettingView.swift
////  iRiver
////
////  Created by 蔡尚儒 on 2023/8/13.
////
//
//import Foundation
//import SwiftUI
//
//struct UserSettingView: View {
//    @State private var setting: Setting
//
//    init(setting: Setting) {
//        _setting = State(initialValue: setting)
//    }
//
//    var body: some View {
//        Form {
//            Section(header: Text("一般設定")) {
//                Picker("語言", selection: $setting.language) {
//                    Text("中文").tag("ch")
//                    Text("英文").tag("en")
//                    // ... 如果有其他語言，也可以在此添加
//                }
//
//                Toggle("音訊自動播放", isOn: $setting.isAudioAutoPlay)
//
//                Toggle("Wi-Fi 自動下載", isOn: $setting.isWifiAutoDownload)
//            }
//
//            Section(header: Text("音訊設定")) {
//                Picker("音質", selection: $setting.audioQuality) {
//                    Text("自動").tag("auto")
//                    Text("高").tag("high")
//                    Text("中").tag("medium")
//                    Text("低").tag("low")
//                }
//
//                Picker("模態顯示", selection: $setting.showModal) {
//                    Text("自動").tag("auto")
//                    // 如果有其他選項，可以在這裡添加
//                }
//            }
//        }
//        .navigationBarTitle("設定", displayMode: .inline)
//    }
//}
//
//struct UserSettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            UserSettingView(setting: Setting(
//                audioAutoPlay: 1,
//                audioQuality: "auto",
//                language: "ch",
//                showModal: "auto",
//                wifiAutoDownload: 0,
//                uid: "sampleUID"
//            ))
//        }
//    }
//}
//
