//
//  OnBoardingPageView.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct OnBoardingPageView: View {
    let page: OnBoardingPage

    var body: some View {
        VStack(spacing: 10) {
            Text(page.title)
                .font(.poppins(.semibold, size: 28))
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Text(page.description)
                .font(.inter(.regular, size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: 320)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OnBoardingPageView(page: .secondPage)
}
