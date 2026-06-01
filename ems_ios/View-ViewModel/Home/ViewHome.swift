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
        ZStack {
            Text("Home")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
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
                            .foregroundStyle(COLOR_BLACK)
                    }
                )
                Spacer()
            }
        }
        .padding([.leading, .top, .trailing], 10)
        Spacer()
        Text("Home")
        Spacer()
    }
}
#Preview {
    ViewHome()
        .environmentObject(RouteCoordinator())
}
