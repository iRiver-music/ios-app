//
//  TestView.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//
import SwiftUI
import FirebaseAuth

struct TestView: View {
    @State private var token: String? = nil
    @State private var resultText: String = ""

    var body: some View {
        VStack {
            Text(resultText)
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        if let user = Auth.auth().currentUser {
            user.getIDToken(completion: { (token, error) in
                if let error = error {
                    print("獲取 ID Token 錯誤：", error.localizedDescription)
                    return
                }
                if let token = token {
                    let uid = getCurrentFirebaseUID()!
                    let invited_by_code = "dbd2707a-0c74-4e80-b035-a743961a507f"
                    let username = "test0813"
//                    let uid = "123"
//                    print("獲取到的  UID  =>", uid)
//                    print("獲取到的 ID Token：", token)
                    
//                    getUserData postUserData
                    postUserData(firebaseToken: token, uid: uid,invited_by_code: invited_by_code,username: username) { result in
                        switch result {
                        case .success(let data):
                            self.resultText = "Success: \(data)"
                            print(data)
                        case .failure(let error):
                            self.resultText = "Error: \(error)"
                        }}
                }
            })
        } else {
            print("用戶未登入")
        }
    }
}
