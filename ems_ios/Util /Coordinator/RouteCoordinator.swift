//
//  RouteCoordinator.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
import Combine
enum AppScreen{
    case login
    case splash
    case tabbar
    case sideMenu
    case userProfile
}
class RouteCoordinator: ObservableObject{
    @Published var selectedTab: Int = 0
    @Published var currentScreen: AppScreen = .splash
    func navigate(to: AppScreen){
        currentScreen = to
    }
}
struct ViewRoot: View{
    @EnvironmentObject var coordinator: RouteCoordinator
    var body: some View{
        switch coordinator.currentScreen{
        case .login:
            ViewLogin()
                .environmentObject(coordinator)
        case .splash:
                ViewSplash()
                    .environmentObject(coordinator)
        case .tabbar:
            ViewTabBar()
                .environmentObject(coordinator)
        case .sideMenu:
            ViewSideMenu()
                .transition(.move(edge: .leading))
                .environmentObject(coordinator)
        case .userProfile:
            ViewUserProfile()
                .environmentObject(coordinator)
        }
    }
}
