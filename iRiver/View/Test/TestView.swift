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
        // 檢查是否有當前登入的用戶
        guard let user = Auth.auth().currentUser else {
            print("用戶未登入")
            return
        }

        // 獲取用戶的 ID Token
        user.getIDToken(completion: { (token, error) in
            // 處理獲取 ID Token 時的錯誤
            if let error = error {
                print("獲取 ID Token 錯誤：", error.localizedDescription)
                return
            }

            // 確保我們有 token 和 uid
            guard let token = token, let uid = getCurrentFirebaseUID() else {
                return
            }

            // 測試數據
            let invited_by_code = "dbd2707a-0c74-4e80-b035-a743961a507f"
            let username = "test0813"

            // 發送 POST 請求
            postUserData(firebaseToken: token, uid: uid, invited_by_code: invited_by_code, username: username) { result in
                switch result {
                case .success(var data):
                    self.resultText = "Success: \(data)"
                    if let message = data["mes"] as? String, message == "uid exists" {
                        // 當帳號存在時，執行 GET 請求來獲取用戶資料
                        getUserData(firebaseToken: token, uid: uid, invited_by_code: invited_by_code, username: username) { getResult in switch getResult {
                                case .success(let data2):
                                    self.resultText = "Success: \(data2)"
                                    data = data2
                                case .failure(let getError):
                                    print("Error getting user data: \(getError)")
                            }
                        }
                    }
                case .failure(let error):
                    self.resultText = "Error: \(error)"
                }
            }
        })
    }

    
}
