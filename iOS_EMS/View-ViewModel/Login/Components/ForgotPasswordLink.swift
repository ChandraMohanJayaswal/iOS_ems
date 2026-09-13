//
//  ForgotPasswordLink.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct ForgotPasswordLink: View {
    var body: some View {
        HStack {
            Spacer()

            Button {
            } label: {
                Text("Forgot Password?")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(blue)
            }
        }
    }
}

#Preview {
    ForgotPasswordLink()
        .padding()
}