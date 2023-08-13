//
//  LoginController.swift
//  myproject
//
//  Created by 蔡尚儒 on 2023/8/10.
//

import Foundation
import SwiftUI


struct MainControl: View {
    @State private var isLoggedIn = false
    @State private var showForgotPassword = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                TestView()
            } else if showForgotPassword {
                ForgotPasswordView(showForgotPassword: $showForgotPassword)
            } else {
                LoginRegisterView(isLoggedIn: $isLoggedIn, showForgotPassword: $showForgotPassword)
            }
        }
    }
}
