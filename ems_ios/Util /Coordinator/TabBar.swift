//
//  TabBar.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
struct ViewTabBar:View{
    @EnvironmentObject var coordinator: RouteCoordinator
    var body: some View{
        TabView(selection:$coordinator.selectedTab){
            Tab("", systemImage:"house", value: TABINDEX.HOME.rawValue){
                ViewHome()
            }
            .accessibilityIdentifier("tab_home")
            
            Tab("", systemImage:"calendar", value: TABINDEX.PUBLICHOLIDAYS.rawValue){
                ViewPublicHolidays()
            }
            .accessibilityIdentifier("tab_public_holidays")
            
            Tab("", systemImage:"pencil", value:TABINDEX.LEAVEREQUESTS.rawValue){
                ViewLeaveRequests()
            }
            .accessibilityIdentifier("tab_leave_requests")
            
            Tab("", systemImage:"calendar.and.person", value:TABINDEX.PERSONALLEAVES.rawValue){
                ViewPersonalLeave()
            }
            .accessibilityIdentifier("tab_personal_leave")
        }
    }
}
