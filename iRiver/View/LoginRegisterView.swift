//
//  LoginView.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/9.
//

import Foundation
import SwiftUI
import FirebaseAuth
import GoogleSignIn
import LineSDK

//google base
struct GoogleSignInButton: UIViewRepresentable {
    let action: () -> Void
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped), for: .touchUpInside)
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }
    class Coordinator: NSObject {
        let action: () -> Void
        init(action: @escaping () -> Void) {
            self.action = action
        }
        @objc func buttonTapped() {
            action()
        }
    }
}

//line base
struct LineSignInButton: UIViewRepresentable {
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Login with LINE", for: .normal)
        button.backgroundColor = .green
        button.addTarget(context.coordinator, action: #selector(Coordinator.buttonTapped), for: .touchUpInside)
        return button
    }
    func updateUIView(_ uiView: UIButton, context: Context) {}
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    class Coordinator: NSObject {
        @objc func buttonTapped() {
            LoginManager.shared.login(permissions: [.profile], in: nil) { result in
                switch result {
                case .success(let loginResult):
                    print("Token:", loginResult.accessToken.value)
                    // 进行其他操作，如获取用户的 LINE 个人资料
                case .failure(let error):
                    print("Error occurred during login:", error)
                }
            }
        }
    }
}

struct LoginRegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @Binding var isLoggedIn: Bool
    @Binding var showForgotPassword: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("電子郵件", text: $email)
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("密碼", text: $password)
                    .padding()
                
                if !isLoggedIn {
                    Button(action: {
                        self.register()
                    }) {
                        Text("註冊")
                    }
                    .padding()
                }
                
                Button(action: {
                    self.login()
                }) {
                    Text("登錄")
                }
                .padding()
                
                Text(message)
                
                GoogleSignInButton(action: GoogleSignIn)
                    .frame(width: 220, height: 48)
                LineSignInButton()
                            .frame(width: 200, height: 40)
                Button("Forgot Password") {
                    showForgotPassword = true
                }

            }
            .padding()
            
        }
    }
 
    
    private func LineSignIn() {
        print("Starting Line sign in process")
        let providerID = "oidc.line"
        let provider = OAuthProvider(providerID: providerID)
        provider.getCredentialWith(nil, completion: { credential, error in
            if let error = error {
                // Handle error.
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let credential = credential {
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("An error occurred: \(error.localizedDescription)")
                        return
                    }
                    print("User successfully signed in!")
                }
            }
        })
    }
    
    
    private func GoogleSignIn() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            let config = GIDConfiguration(clientID: "550185976250-os92dqqpkloj0eb66eu4cjnpcgcbuga6.apps.googleusercontent.com")
            GIDSignIn.sharedInstance.signIn(with: config, presenting: rootViewController) { user, error in
                if let error = error {
                    print(error)
                } else {
                    if let authentication = user?.authentication {
                        let credential = GoogleAuthProvider.credential(
                            withIDToken: "",accessToken: authentication.accessToken)
                        Auth.auth().signIn(with: credential) { (authResult, error) in
                            if let error = error {
                                self.message = "Firebase 登录错误：\(error.localizedDescription)"
                                print(error)
                            } else {
                                self.message = "用戶登錄成功！(firebase)"
                                self.isLoggedIn = true // 登錄成功後將登錄狀態設置為true
                                print("firebase 登入成功")
                            }
                        }
                    }
                }
            }
        }
    }
    


    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.message = "註冊錯誤：\(error.localizedDescription)"
            } else {
                self.isLoggedIn = true // 註冊成功後將登錄狀態設置為true
                self.message = "用戶註冊成功！"
                self.email = "" // 註冊成功後重置電子郵件字段
                self.password = "" // 註冊成功後重置密碼字段
            }
        }
    }
    
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.message = "登錄錯誤：\(error.localizedDescription)"
            } else {
                self.isLoggedIn = true // 登錄成功後將登錄狀態設置為true
                self.message = "用戶登錄成功！"
            }
        }
    }
    
    
}

//struct LoginRegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginRegisterView()
//    }
//}
