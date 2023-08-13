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
//                    print("獲取到的  UID  =>", uid)
//                    print("獲取到的 ID Token：", token)
                    postUserData(firebaseToken: token, uid: uid) { result in
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
