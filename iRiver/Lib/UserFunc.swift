//
//  UserModel.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//
import Foundation

func postUserData(firebaseToken: String, uid: String, invited_by_code: String, username: String, completionHandler: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
    
    guard let url = URL(string: "http://49.213.238.75:5000/api/auth/\(uid)/") else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"

    
    // 設定Content-Type和Authorization頭部
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
    
    // 增加多個參數
    let parameters: [String: Any] = [
        "uid": uid,
        "invited_by_code": invited_by_code,
        "username": username
    ]
    
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



func getUserData(firebaseToken: String, uid: String, invited_by_code: String, username: String, completionHandler: @escaping (Result<Dictionary<String, Any>, Error>) -> Void) {
    
    // 創建查詢參數
    let queryItems = [
        URLQueryItem(name: "uid", value: uid),
        URLQueryItem(name: "invited_by_code", value: invited_by_code),
        URLQueryItem(name: "username", value: username)
    ]
    
    var urlComponents = URLComponents(string: "http://49.213.238.75:5000/api/auth/\(uid)/")
    urlComponents?.queryItems = queryItems
    
    guard let url = urlComponents?.url else {
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    // 設定Content-Type和Authorization頭部
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(firebaseToken)", forHTTPHeaderField: "Authorization")
    
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



