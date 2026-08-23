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
        .header(title: "Home")
    }
}
#Preview {
    ViewHome()
        .environmentObject(RouteCoordinator())
}
