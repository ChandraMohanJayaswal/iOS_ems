//
//  ViewLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//
import SwiftUI

struct ViewLogin: View {
    @StateObject var viewModel: ViewModelLogin = .init()
    @EnvironmentObject var coordinator: RouteCoordinator
    var body: some View {
        ZStack {
            AppBackground()
            VStack {
                BrandHeader()
                Spacer()
                AppWindow(label: "Login")
                    .frame(height: 270)
                    .padding(.horizontal, 32)
                Spacer()
                loginForm
                    .padding()
                Spacer()
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    ViewLogin()
}

private extension ViewLogin {

    var loginForm: some View {
        LoginForm(
            email: $viewModel.email,
            password: $viewModel.password,
            showPassword: $viewModel.showPassword,
            isFormValid: viewModel.isFormValid,
            isLoading: viewModel.uiState == .loading,
            onSignIn: signIn
        )
    }

    func signIn() {
        Task {
            await viewModel.login()
            if !viewModel.errorOccured {
                coordinator.navigate(
                    to: .tabbar
                )
            }
        }
    }
}
