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

#Preview {
    LoginFormPreview()
}

private struct LoginFormPreview: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false

    var body: some View {
        LoginForm(
            email: $email,
            password: $password,
            showPassword: $showPassword,
            isFormValid: true,
            isLoading: false,
            onSignIn: {}
        )
        .padding()
    }
}
