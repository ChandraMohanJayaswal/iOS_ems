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
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                .foregroundStyle(.background)
                .offset(x: 180, y: -380)
                .frame(width: 200, height: 200)

            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                .foregroundStyle(.background)
                .offset(x: 180, y: 300)
                .frame(width: 150, height: 150)
            Rectangle()
                .stroke(Color.black.opacity(0.1), lineWidth: 0)
                .foregroundStyle(.background)
                .background(orange.opacity(0.6))
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: 45))
                .offset(x: 100, y: -100)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black.opacity(0.1), lineWidth: 6)
                .foregroundStyle(.background)
                .frame(width: 80, height: 80)
                .rotationEffect(Angle(degrees: 150))
                .offset(x: -190, y: -150)
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 2)
                .background(orange.opacity(0.5))
                .clipShape(Circle())
                .frame(width: 20, height: 20)
                .offset(x: -150, y: 250)
            VStack {
                Text("EMS")
                    .font(.poppins(.bold, size: 34))
                    .foregroundStyle(blue)
                Text("By Chronelab Technologies")
                    .font(.inter(.bold, size: 24))
                    .foregroundStyle(.gray)
                Spacer()
                ZStack(alignment: .topLeading) {

                    // Hard offset shadow
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.78, green: 0.80, blue: 0.90))
                        .offset(x: 0, y: 7)

                    // Main window
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.94, green: 0.95, blue: 1.0))
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(
                                    Color(red: 0.08, green: 0.10, blue: 0.17),
                                    lineWidth: 2.5
                                )
                        }
                    // Content
                    VStack {
                        Image("SplashLogo")
                            .resizable()
                            .frame(height: 220)
                        Spacer()
                        HStack(spacing: 6) {
                            Circle()
                                .fill(Color(red: 0.95, green: 0.35, blue: 0.45))
                                .frame(width: 8, height: 8)
                                .overlay {
                                    Circle()
                                        .stroke(
                                            .black.opacity(0.35),
                                            lineWidth: 0.8
                                        )
                                }
                            Circle()
                                .fill(Color(red: 1.0, green: 0.75, blue: 0.15))
                                .frame(width: 8, height: 8)
                                .overlay {
                                    Circle()
                                        .stroke(
                                            .black.opacity(0.35),
                                            lineWidth: 0.8
                                        )
                                }

                            Circle()
                                .fill(Color(red: 0.25, green: 0.30, blue: 0.75))
                                .frame(width: 8, height: 8)
                                .overlay {
                                    Circle()
                                        .stroke(
                                            .black.opacity(0.35),
                                            lineWidth: 0.8
                                        )
                                }
                        }
                    }
                    .padding(12)
                    // WORKSPACE label
                    Text("Employee Portal")
                        .font(
                            .system(size: 11, weight: .bold, design: .rounded)
                        )
                        .tracking(0.5)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.yellow)
                        )
                        .overlay {
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(.black, lineWidth: 2)
                        }
                        .offset(x: 24, y: -11)
                }
                .frame(height: 270)
                .padding(.horizontal, 32)
                Spacer()
                LoadingBar()
                    .padding(.bottom)
                HStack(spacing: 7) {
                    SyncIndicator()
                    Text("Synchronizing attendance...")
                        .font(
                            .system(
                                size: 11,
                                weight: .medium,
                                design: .monospaced
                            )
                        )
                        .foregroundStyle(Color(.black))
                }
            }
            .padding(.top, 50)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                if EMSManager.shared.isLoggedIn {
                    coordinator.navigate(to: .tabbar)
                } else {
                    coordinator.navigate(to: .login)
                }
            }
        }
    }
}
