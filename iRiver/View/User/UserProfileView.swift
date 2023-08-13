//
//  UserProfileView.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//

import Foundation
import SwiftUI
import FirebaseAuth

//struct UserProfileView: View {
//    
//    var user: User? = Auth.auth().currentUser
//
//    var body: some View {
//        VStack {
//            if let user = user {
//                Text("Name: \(user.displayName ?? "Unknown")")
//                Text("Email: \(user.email ?? "Unknown")")
//
//                if let photoURL = user.photoURL {
//                    // 如果 Firebase 提供了一個頭像 URL，你可以使用其他第三方套件例如 SDWebImageSwiftUI 來加載和顯示網路圖片。
//                    // Image(url: photoURL)
//                    // 此部分僅為示範，實際上要顯示遠端圖片需要更多的設置和第三方工具的支援。
//                }
//            } else {
//                Text("No user is logged in.")
//            }
//        }
//        .padding()
//    }
//}
//
//struct UserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserProfileView()
//    }
//}
