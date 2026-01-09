//
//  ViewModelSideMenu.swift
//  ems_ios
//
//  Created by MacMini on 25/12/2025.
//
import Foundation
import KeychainSwift
import Combine
class ViewModelSideMenu : ObservableObject{
    @Published var showBackground: Bool = false
    func signOut(coordinator: RouteCoordinator){
        coordinator.selectedTab = TABINDEX.HOME.rawValue
        KeychainSwift().clear()
        coordinator.navigate(to: .login)
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
