//
//  LoginForm.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct LoginForm: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var showPassword: Bool
    let isFormValid: Bool
    let isLoading: Bool
    let onSignIn: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            InputLabel(text: "Work Email")
            EmailField(email: $email)

            InputLabel(text: "Password")
                .padding(.top, 13)
            PasswordField(password: $password, showPassword: $showPassword)

            ForgotPasswordLink()
                .padding(.top, 9)

            SignInButton(
                isFormValid: isFormValid,
                isLoading: isLoading,
                action: onSignIn
            )
            .padding(.top, 19)
        }
    }
}