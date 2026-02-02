//
//  UserDefaultsManager.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import KeychainSwift
import Foundation
final class UserDefaultsManager{
    static let shared = UserDefaultsManager()
    private init(){
    }
    func login(firstName: String, lastName: String, gender: String, emailAddress: String, mobileNumber: String, title: String, token: String){
        UserDefaults.standard.set(firstName, forKey:"firstName")
        UserDefaults.standard.set(lastName, forKey:"lastName")
        UserDefaults.standard.set(gender, forKey: "gender")
        UserDefaults.standard.set(emailAddress, forKey: "emailAddress")
        UserDefaults.standard.set(mobileNumber, forKey: "mobileNumber")
        UserDefaults.standard.set(title, forKey: "title")
        KeychainSwift().set(token, forKey:"user_token")
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
    }
    func signOut(coordinator: RouteCoordinator){
        coordinator.selectedTab = TABINDEX.HOME.rawValue
        KeychainSwift().clear()
        coordinator.navigate(to: .login)
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
