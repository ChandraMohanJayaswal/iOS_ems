//
//  ViewModelSideMenu.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//
import Foundation
import Combine
class ViewModelSideMenu: ObservableObject {
    @Published var showBackground: Bool = false
    func signOut(coordinator: RouteCoordinator) {
        EMSManager.shared.signOut()
        coordinator.selectedTab = TABINDEX.HOME.rawValue
        coordinator.navigate(to: .login)
    }

    deinit {
        print("ViewModelSideMenu deinitialized")
    }
}
