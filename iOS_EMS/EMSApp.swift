//
//  EmsApp.swift
//  iOS_EMS
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI
import UIKit
@main
struct EmsApp: App {
    init() {
        applyTabBarAppearance()
    }
    @StateObject var coordinator = RouteCoordinator()
    var body: some Scene {
        WindowGroup {
            ViewRoot()
                .environmentObject(coordinator)
        }
    }
}

private func applyTabBarAppearance() {
    let appearance = UITabBarAppearance()
    appearance.configureWithDefaultBackground()
    let font = UIFont(name: "Poppins-Medium", size: 10) ?? .systemFont(ofSize: 10)
    for layout in [
        appearance.stackedLayoutAppearance,
        appearance.inlineLayoutAppearance,
        appearance.compactInlineLayoutAppearance
    ] {
        layout.normal.titleTextAttributes = [.font: font]
        layout.selected.titleTextAttributes = [.font: font]
    }
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
}
