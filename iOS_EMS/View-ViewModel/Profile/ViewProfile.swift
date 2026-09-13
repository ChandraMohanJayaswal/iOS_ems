//
//  ViewProfile.swift
//  iOS_EMS
//
//  Created by MacMini on 08/09/2026.
//

import SwiftUI

struct ViewProfile: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelUserProfile()
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ProfileCard {
                    viewModel.isSheetShown = true
                }
                ProfileDetailsCard(
                    role: viewModel.role,
                    gender: viewModel.gender.rawValue,
                    mobileNumber: viewModel.mobileNumber,
                    emailAddress: viewModel.emailAddress
                )
                SignOutButton {
                    signOut()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .header(title: "Profile")
        .sheet(isPresented: $viewModel.isSheetShown) {
            EditProfileSheet(viewModel: viewModel) {
                viewModel.isSheetShown = false
            }
        }
    }

    private func signOut() {
        EMSManager.shared.signOut()
        coordinator.selectedTab = TABINDEX.HOME.rawValue
        coordinator.navigate(to: .login)
    }
}

#Preview {
    ViewProfile()
        .environmentObject(RouteCoordinator())
}