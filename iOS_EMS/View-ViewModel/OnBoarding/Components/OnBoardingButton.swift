//
//  OnBoardingButton.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct OnBoardingButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                Image(systemName: "arrow.right")
                    .font(.system(size: 13, weight: .bold))
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 42)
        }
        .background(blue)
        .clipShape(RoundedRectangle(cornerRadius: 11))
        .padding()
    }
}

#Preview {
    OnBoardingButton(title: "Continue") {
        print("Tapped")
    }
}
