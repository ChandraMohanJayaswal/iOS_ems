//
//  SubmitLeaveButton.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct SubmitLeaveButton: View {
    let isFormValid: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text("Submit")
                    .font(.inter(.semibold, size: 17))
                Image(systemName: "paperplane")
                Spacer()
            }
        }
        .disabled(!isFormValid)
    }
}

#Preview {
    VStack(spacing: 8) {
        SubmitLeaveButton(isFormValid: true) {
            print("Submit tapped")
        }
        SubmitLeaveButton(isFormValid: false) {
            print("Submit tapped")
        }
    }
    .padding()
}
