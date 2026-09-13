//
//  SignOutButton.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct SignOutButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "door.right.hand.open")
                Text("Sign Out")
                    .font(.inter(.semibold, size: 17))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .accessibilityIdentifier("signOutButton")
        .padding(.top, 8)
    }
}

#Preview {
    SignOutButton(action: {})
}
