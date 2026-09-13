//
//  SignInButton.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct SignInButton: View {
    let isFormValid: Bool
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Sign In")
                        .font(.system(size: 13, weight: .bold))

                    Image(systemName: "arrow.right")
                        .font(.system(size: 13, weight: .bold))
                }
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 42)
        }
        .accessibilityIdentifier("loginButton")
        .disabled(!isFormValid)
        .background(isFormValid ? blue : Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 11))
    }
}