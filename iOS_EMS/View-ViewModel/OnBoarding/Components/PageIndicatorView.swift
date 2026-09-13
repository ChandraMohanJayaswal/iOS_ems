//
//  PageIndicatorView.swift
//  iOS_EMS
//
//  Created by MacMini on 13/09/2026.
//

import SwiftUI

struct PageIndicatorView: View {
    let currentPage: Int

    var body: some View {
        HStack {
            ForEach(OnBoardingPage.allCases) { page in
                Circle()
                    .fill(currentPage == page.rawValue ? lightGray : warmGray)
                    .frame(
                        width: currentPage == page.rawValue ? 12 : 8,
                        height: currentPage == page.rawValue ? 12 : 8
                    )
                    .animation(.spring(), value: currentPage)
            }
        }
        .padding(.bottom, 25)
    }
}

#Preview {
    PageIndicatorView(currentPage: 1)
}
