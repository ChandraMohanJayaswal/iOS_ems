//
//  ViewHome.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI

struct ViewHome: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    var body: some View {
        VStack {
            Text("Home View")
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(
                    action: {
                        withAnimation(.easeInOut) {
                            coordinator.navigate(to: .sideMenu)
                        }
                    },
                    label: {
                        Image(systemName: "line.3.horizontal")
                            .resizable()
                            .frame(width: 25, height: 15)
                            .foregroundStyle(colorBlack)
                    }
                )
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(
                    action: {
                        withAnimation(.easeInOut) {
//                            coordinator.navigate(to: .sideMenu)
                        }
                    },
                    label: {
                        Image(systemName: "bell")
                            .resizable()
                            .foregroundStyle(colorBlack)
                    }
                )
            }
        }
    }
}
#Preview {
    ViewHome()
        .environmentObject(RouteCoordinator())
}
