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
            
            Tab("", systemImage:"calendar", value: TABINDEX.PUBLICHOLIDAYS.rawValue){
                ViewPublicHolidays()
            }
            
            Tab("", systemImage:"pencil", value:TABINDEX.LEAVEREQUESTS.rawValue){
                ViewLeaveRequests()
            }
            
            Tab("", systemImage:"calendar.and.person", value:TABINDEX.PERSONALLEAVES.rawValue){
                ViewPersonalLeave()
            }
        }
    }
}
