//
//  EmailField.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct EmailField: View {
    @Binding var email: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "envelope")
                .font(.system(size: 13))
                .foregroundStyle(.gray.opacity(0.75))

            TextField(
                text: $email,
                prompt: Text("alex.chen@chronelab.com")
                    .foregroundStyle(.gray.opacity(0.65))
            ) {
            }
            .accessibilityIdentifier("email")
            .font(.system(size: 13, weight: .regular))
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
        }
        .padding(.horizontal, 13)
        .frame(height: 35)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

#Preview {
    EmailFieldPreview()
}

private struct EmailFieldPreview: View {
    @State private var email = ""

    var body: some View {
        EmailField(email: $email)
            .padding()
    }
}
