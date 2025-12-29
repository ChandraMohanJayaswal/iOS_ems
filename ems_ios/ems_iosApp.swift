//
//  ems_iosApp.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI
@main
struct ems_iosApp: App {
    @StateObject var coordinator = RouteCoordinator()
    var body: some Scene {
        WindowGroup {
            ViewRoot()
                .environmentObject(coordinator)
        }
    }
}
