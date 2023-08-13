//
//  UserModel.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//
import Foundation

func postUserData(firebaseToken: String, uid: String, completionHandler: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
    guard let url = URL(string: "http://49.213.238.75:5000/api/auth/\(uid)/") else {
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    // 設定Content-Type和Authorization頭部
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
    let parameters: [String: Any] = ["uid":uid] // 修改為你的POST數據
    let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    request.httpBody = postData
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completionHandler(.failure(error))
            return
        }

        guard let data = data else {
            completionHandler(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }

        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                completionHandler(.success(jsonResponse))
            } else {
                completionHandler(.failure(NSError(domain: "", code: -2, userInfo: nil)))
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
    task.resume()
}


