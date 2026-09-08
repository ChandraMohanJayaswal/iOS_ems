//
//  TabBar.swift
//  iOS_EMS
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI

struct ViewTabBar: View {
    @EnvironmentObject var coordinator: RouteCoordinator
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            Tab("Home", systemImage: "house", value: TABINDEX.HOME.rawValue) {
                NavigationStack {
                    ViewHome()
                }
            }
            .accessibilityIdentifier("tab_home")
            Tab(
                "Calendar",
                systemImage: "calendar",
                value: TABINDEX.PUBLICHOLIDAYS.rawValue
            ) {
                NavigationStack {
                    ViewCalendar()
                }
            }
            .accessibilityIdentifier("tab_public_holidays")
            Tab(
                "Profile",
                systemImage: "person.crop.circle",
                value: TABINDEX.PROFILE.rawValue
            ) {
                NavigationStack {
                    ViewProfile()
                }
            }
            .accessibilityIdentifier("tab_profile")
            Tab(
                "Settings",
                systemImage: "gearshape",
                value: TABINDEX.SETTINGS.rawValue
            ) {
                NavigationStack {
                    ViewSettings()
                }
            }
            .accessibilityIdentifier("tab_settings")
        }
        .tint(blue)
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}
