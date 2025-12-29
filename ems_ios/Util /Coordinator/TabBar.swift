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
            Tab("", systemImage:"house", value: 0){
                ViewHome()
            }
            
            Tab("", systemImage:"calendar", value: 1){
                ViewPublicHolidays()
            }
            
            Tab("", systemImage:"pencil", value: 2){
                ViewLeaveRequests()
            }
            
            Tab("", systemImage:"calendar.and.person", value: 3){
                ViewPersonalLeave()
            }
            
            Tab("Users", systemImage:"person.3", value: 4){
                ViewUsers()
            }
            
            Tab("Utility", systemImage:"wrench.and.screwdriver", value: 5){
                ViewUtility()
            }
        }
    }
}
#Preview{
    ViewTabBar()
}
