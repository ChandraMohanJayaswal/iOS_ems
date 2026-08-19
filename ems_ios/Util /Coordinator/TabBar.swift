//
//  TabBar.swift
//  ems_ios
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
                    ViewPublicHolidays()
                }
            }
            .accessibilityIdentifier("tab_public_holidays")

//            Tab(
//                "",
//                systemImage: "pencil",
//                value: TABINDEX.LEAVEREQUESTS.rawValue
//            ) {
//                NavigationStack {
//                    ViewLeaveRequests()
//                }
//            }
//            .accessibilityIdentifier("tab_leave_requests")
            Tab(
                "Personal Leave",
                systemImage: "pencil",
                value: TABINDEX.PERSONALLEAVES.rawValue
            ) {
                NavigationStack {
                    ViewPersonalLeave()
                }
            }
            .accessibilityIdentifier("tab_personal_leave")
        }
        .tint(darkBlue)
        .tabBarMinimizeBehavior(.onScrollDown)
    }
}
