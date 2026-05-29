//
//  ViewOnBoarding.swift
//  ems_ios
//
//  Created by MacMini on 21/05/2026.
//

import Foundation
import SwiftUI

enum OnBoardingPage: Int, CaseIterable, Identifiable {
    case firstPage
    case secondPage
    case thirdPage
    var id: Int {
        return self.rawValue
    }
    var title: String {
        switch self {
        case .firstPage:
            return "Welcome"
        case .secondPage:
            return "Features"
        case .thirdPage:
            return "Employee Management System"
        }
    }
    var description: String {
        switch self {
        case .firstPage:
            return "Manage your team"
        case .secondPage:
            return "Analytics, Tracking, Management"
        case .thirdPage:
            return "Manage. Engage. Grow"
        }
    }
}
struct ViewOnBoarding: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @State private var currentPage = 0
    @State private var isAnimating = false
    @State private var circleAnimating = false
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [primaryBlue, darkBlue]),
                startPoint: .top,
                endPoint: .bottom
            )
            VStack {
                TabView(selection: $currentPage) {
                    ForEach(OnBoardingPage.allCases) { page in
                        VStack {
                            OnBoardingPageView(page: page)
                        }
                        .tag(page.rawValue)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.spring(), value: currentPage)
                HStack {
                    ForEach(OnBoardingPage.allCases) { page in
                        Circle()
                            .fill(currentPage == page.rawValue ? .white : .gray)
                            .frame(
                                width: currentPage == page.rawValue ? 12 : 8,
                                height: currentPage == page.rawValue ? 12 : 8
                            )
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.bottom, 25)
                if self.currentPage == 2 {
                    Button("Get Started") {
                        coordinator.navigate(to: .login)
                    }
                    .padding()
                    .font(.headline)
                    .frame(width: 350)
                    .foregroundStyle(royalBlue)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                } else {
                    Button("Next") {
                        self.currentPage += 1
                    }
                    .padding()
                    .font(.headline)
                    .frame(width: 350)
                    .foregroundStyle(royalBlue)
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                }
            }
            .padding(.bottom, 50)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ViewOnBoarding()
}

struct OnBoardingPageView: View {
    @State var page: OnBoardingPage
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack {
            if page.rawValue == 2 {
                Image(systemName: "person.2.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .background(
                        mutedLavender
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
            }
            Text(page.title)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .offset(x: 0, y: isAnimating ? 0 : -200)
                .animation(.smooth.delay(0.2), value: isAnimating)
                .frame(width: 300)
            ZStack {
                Circle()
                    .stroke()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(iconGlow)
                    .scaleEffect(isAnimating ? 1.2 : 0.9)
                    .animation(
                        .spring().delay(0.4),
                        value: isAnimating
                    )
                Image("People")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(isAnimating ? 0.9 : 1.2)
                    .animation(.smooth.delay(0.2), value: isAnimating)
            }
            Text(page.description)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .offset(x: 0, y: isAnimating ? 0 : 200)
                .animation(.smooth, value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}
