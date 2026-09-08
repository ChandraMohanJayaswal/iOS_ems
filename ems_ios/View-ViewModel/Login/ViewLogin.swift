//
//  ViewLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//
import SwiftUI

struct ViewLogin: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @StateObject var viewModel = ViewModelLogin()
    var body: some View {
        VStack {
            ZStack {
//                LinearGradient(
//                    gradient: Gradient(colors: [primaryBlue, darkBlue]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
                Circle()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [paleLavender, Color.white.opacity(0)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .offset(x: -200, y: -400)
                    .frame(width: 250, height: 250)
                Circle()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.white.opacity(0), paleLavender],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .offset(x: 200, y: 400)
                    .frame(width: 250, height: 250)
                VStack {
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
                    Text("Welcome Back")
                        .font(.poppins(.medium, size: 25))
                        .padding(.bottom, 5)
                    Text("Sign in to continue to your account")
                        .font(.inter(size: 14))
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundStyle(Color.black.opacity(0.5))
                            .padding(.leading, 10)

                        TextField(
                            text: $viewModel.email,
                            prompt: Text("Email Address")
                                .foregroundStyle(
                                Color.black.opacity(0.5)
                            )
                        ) {
                        }
                        .accessibilityIdentifier("email")
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)

                    }
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding([.leading, .trailing], 6)
                    .padding([.top, .bottom], 20)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 12
                        )
                        .stroke(ashWhite, lineWidth: 3)
                    )
                    .background(paleLavender)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .padding([.leading, .trailing], 10)
                    .padding(.top, 20)
                    HStack {
                        Image(systemName: "lock")
                            .foregroundStyle(Color.black.opacity(0.5))
                            .padding(.leading, 10)

                        if viewModel.showPassword {
                            TextField(
                                text: $viewModel.password,
                                prompt: Text("Password").foregroundStyle(
                                    Color.black.opacity(0.5)
                                )
                            ) {
                            }
                            .accessibilityIdentifier("passwordField")
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        } else {
                            SecureField(
                                text: $viewModel.password,
                                prompt: Text("Password").foregroundStyle(
                                    Color.black.opacity(0.5)
                                )
                            ) {
                            }
                            .accessibilityIdentifier("passwordField")
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        }
                        Spacer()
                        Button(
                            action: {
                                viewModel.showPassword.toggle()
                            },
                            label: {
                                if viewModel.showPassword {
                                    Image(systemName: "eye.slash.fill")
                                } else {
                                    Image(systemName: "eye.fill")
                                }
                            }
                        )
                        .accessibilityIdentifier("toggleHidePassword")
                    }
                    .foregroundStyle(Color.black.opacity(0.5))
                    .padding([.leading, .trailing], 6)
                    .padding([.top, .bottom], 20)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 12
                        )
                        .stroke(ashWhite, lineWidth: 3)
                    )
                    .background(paleLavender)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .padding([.leading, .trailing], 10)
                    .padding(.top, 10)
                    Button(
                        action: {
                            Task {
                                await viewModel.login()
                                if !viewModel.errorOccured {
                                    coordinator.navigate(to: .tabbar)
                                }
                            }
                        },
                        label: {
                            if viewModel.uiState == .loading {
                                ProgressView()
                                    .tint(Color.white)
                            } else if viewModel.uiState == .idle {
                                Text("Sign In")
                                    .foregroundStyle(.white)
                                    .font(.inter(.semibold, size: 17))
                            }
                        }
                    )
                    .accessibilityIdentifier("loginButton")
                    .disabled(!viewModel.isFormValid)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isFormValid ? darkBlue : .gray)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 10)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(viewModel.isFormValid ? .black : .gray, lineWidth: 0)
                    )
                    .padding([.leading, .trailing], 10.5)
                    .padding(.top, 10)
                    Text("Forgot Password?")
                        .foregroundStyle(.black)
                        .padding(.top, 10)
                }
            }
            .ignoresSafeArea()
        }
        .alert("Alert", isPresented: $viewModel.errorOccured) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
                .accessibilityIdentifier("loginErrorMessage")
        }
    }
}
