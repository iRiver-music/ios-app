//
//  ResetView.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var showForgotPassword: Bool

    var body: some View {
        VStack(spacing: 16) {
            Text("忘記密碼")
                .font(.largeTitle)
                .padding(.bottom, 50)
            
            TextField("請輸入註冊的電子郵件", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button(action: ResetPassword) {
                Text("重設密碼")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Button("Back to Login") {
                self.showForgotPassword = false
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("信息"), message: Text(alertMessage), dismissButton: .default(Text("確定")))
        }
    }
    
    func ResetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                alertMessage = "重設密碼的連結已經發送到您的電子郵件。請查看並按照指示進行。"
                showAlert = true
            }
        }
    }
}

//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}
