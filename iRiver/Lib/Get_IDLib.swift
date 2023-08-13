//
//  BaseLib.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//

import Foundation
import FirebaseAuth

func getCurrentFirebaseUID() -> String? {
    return Auth.auth().currentUser?.uid
}

func getFirebaseIDToken(completion: @escaping (String?, Error?) -> Void) {
    if let user = Auth.auth().currentUser {
        user.getIDToken(completion: { (token, error) in
            if let error = error {
                // 處理錯誤
                completion(nil, error)
                return
            }
            
            if let token = token {
                // 成功獲取 ID Token
                completion(token, nil)
            }
        })
    } else {
        // 用戶未登入
        let notLoggedInError = NSError(domain: "com.yourapp", code: 401, userInfo: [NSLocalizedDescriptionKey: "用戶未登入"])
        completion(nil, notLoggedInError)
    }
}


func fetchFirebaseToken(completion: @escaping (String?) -> Void) {
    if let currentUser = Auth.auth().currentUser {
        currentUser.getIDToken(completion: { (token, error) in
            if let error = error {
                print("Error fetching token: \(error.localizedDescription)")
                completion(nil)
            } else if let token = token {
                completion(token)
            }
        })
    } else {
        print("User not signed in.")
        completion(nil)
    }
}

func decodeIDTokenKid(_ idToken: String) -> String? {
    let tokenComponents = idToken.components(separatedBy: ".")
    
    guard tokenComponents.count >= 2,
          let headerData = Data(base64Encoded: tokenComponents[0]),
          let headerJSON = try? JSONSerialization.jsonObject(with: headerData, options: []) as? [String: Any],
          let kid = headerJSON["kid"] as? String
    else {
        print("Header 解碼失敗")
        return nil
    }
    
    return kid
}




