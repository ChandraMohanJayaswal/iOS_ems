import Foundation
//
//  UserDefaultsManager.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import KeychainSwift

final class EMSManager {
    static let shared = EMSManager()
    private let userDefaults: UserDefaults
    private let keychain: KeychainSwift
    private init(userDefaults: UserDefaults = .standard, keychain: KeychainSwift = KeychainSwift()) {
        self.userDefaults = userDefaults
        self.keychain = keychain
    }
    var currentUser: User? {
        guard let data = userDefaults.data(forKey: "loggedUser") else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    var isLoggedIn: Bool {
        userDefaults.bool(forKey: "isUserLoggedIn")
    }
    func login(
        user: User,
        token: String
    ) {
        do {
            let data = try JSONEncoder().encode(user)
            userDefaults.set(data, forKey: "loggedUser")
            userDefaults.set(true, forKey: "isUserLoggedIn")
            KeychainSwift().set(token, forKey: "user_token")
        } catch {
            print("Failed to encode user: \(error)")
        }
    }

    func signOut() {
        keychain.clear()
        userDefaults.set(false, forKey: "isUserLoggedIn")
        userDefaults.removeObject(forKey: "loggedUser")
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
