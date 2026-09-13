//
//  ViewOnBoarding.swift
//  iOS_EMS
//
//  Created by MacMini on 21/05/2026.
//

import Foundation
import SwiftUI

struct ViewOnBoarding: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @State private var currentPage = 0

    private var heroImage: String {
        switch currentPage {
        case 1: return "HeroImageFirst"
        case 2: return "HeroImageSecond"
        default: return "SplashLogo"
        }
    }

    var body: some View {
        ZStack {
            AppBackground()
            VStack {
                BrandHeader()
                    .padding(.bottom, 10)
                AppWindow(
                    label: "ONBOARDING 0\(self.currentPage + 1)/03",
                    image: heroImage,
                    fillsFrame: true
                )
                    .frame(height: 270)
                    .padding(.horizontal, 32)
                TabView(selection: $currentPage) {
                    ForEach(OnBoardingPage.allCases) { page in
                        OnBoardingPageView(page: page)
                            .tag(page.rawValue)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                Spacer()
                PageIndicatorView(currentPage: currentPage)
                if self.currentPage == 2 {
                    OnBoardingButton(title: "Get Started") {
                        coordinator.navigate(to: .login)
                    }
                } else {
                    OnBoardingButton(title: "Next") {
                        self.currentPage += 1
                    }
                }
            }
            .padding(.top, 50)
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ViewOnBoarding()
}
