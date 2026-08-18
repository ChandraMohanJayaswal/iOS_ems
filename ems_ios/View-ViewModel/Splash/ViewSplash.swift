//
//  ViewSplash.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//
import SwiftUI

struct ViewSplash: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    @State private var angle: CGFloat = 0
    @StateObject var viewModel = ViewModelSplash()
    @State private var scaledValue: CGFloat = 1
    var body: some View {
        Text("EMS")
            .font(.largeTitle)
            .foregroundStyle(.blue)
            .fontWeight(.heavy)
        Text("By Chronelabs Technologies")
            .foregroundStyle(.gray)
        ZStack(alignment: .topTrailing) {
            Image(systemName: "person.2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scaledValue)
                .animation(
                    .easeInOut(duration: 2).repeatForever(autoreverses: true),
                    value: scaledValue
                )
                .frame(width: 150, height: 100)
                .foregroundStyle(.blue)
                .padding(40)
            Image(systemName: "gearshape")
                .foregroundStyle(.blue)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(angle))
                .animation(
                    .easeInOut(duration: 2).repeatForever(autoreverses: true),
                    value: angle
                )
                .onAppear {
                    angle = 360
                    scaledValue = 1.2
                    if viewModel.shouldSkipSplash {
                        coordinator.navigate(to: .tabbar)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        coordinator.navigate(to: .tabbar)
                        if UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
                        } else {
                            coordinator.navigate(to: .login)
                        }
                    }
                }
        }
    }
}
