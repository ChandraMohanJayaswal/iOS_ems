//
//  PasswordField.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @Binding var showPassword: Bool

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "lock")
                .font(.system(size: 13))
                .foregroundStyle(.gray.opacity(0.75))

            if showPassword {
                TextField(
                    text: $password,
                    prompt: Text("Password")
                        .foregroundStyle(.gray.opacity(0.65))
                ) {
                }
                .accessibilityIdentifier("passwordField")
                .font(.system(size: 13, weight: .regular))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            } else {
                SecureField(
                    text: $password,
                    prompt: Text("Password")
                        .foregroundStyle(.gray.opacity(0.65))
                ) {}
                .accessibilityIdentifier("passwordField")
                .font(.system(size: 13, weight: .regular))
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            }

            Button {
                showPassword.toggle()
            } label: {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .font(.system(size: 13))
                    .foregroundStyle(.gray.opacity(0.7))
            }
            .accessibilityIdentifier("toggleHidePassword")
        }
        .padding(.horizontal, 13)
        .frame(height: 38)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 1)
        }
    }
}