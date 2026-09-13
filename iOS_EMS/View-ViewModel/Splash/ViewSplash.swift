//
//  ViewSplash.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//
import SwiftUI

struct ViewSplash: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelSplash()
    var body: some View {
        ZStack {
            AppBackground()

            VStack {
                BrandHeader()
                Spacer()
                AppWindow(label: "Employee Portal")
                    .frame(height: 270)
                    .padding(.horizontal, 32)
                Spacer()
                LoadingBar()
                    .padding(.bottom)
                SyncStatusView()
            }
            .padding(.top, 50)
        }
        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                coordinator.navigate(to: .onBoarding)
//                if EMSManager.shared.isLoggedIn {
//                    coordinator.navigate(to: .tabbar)
//                } else {
//                    coordinator.navigate(to: .login)
//                }
//            }
        }
    }
}
