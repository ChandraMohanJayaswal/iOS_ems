//
//  ViewUserProfile.swift
//  iOS_EMS
//
//  Created by MacMini on 26/12/2025.
//

import SwiftUI

struct ViewUserProfile: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelUserProfile()
    var body: some View {
        NavigationStack {
            ProfileForm(viewModel: viewModel)
                .sheet(isPresented: $viewModel.isSheetShown) {
                    EditProfileSheet(viewModel: viewModel) {
                        viewModel.isSheetShown = false
                    }
                }
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ProfileHeader(
                        title: "Profile Details",
                        onBack: {
                            withAnimation(.easeInOut) {
                                coordinator.navigate(to: .tabbar)
                            }
                        },
                        onEdit: {
                            viewModel.isSheetShown.toggle()
                        }
                    )
                }
        }
    }
}

#Preview {
    ViewUserProfile()
        .environmentObject(RouteCoordinator())
}