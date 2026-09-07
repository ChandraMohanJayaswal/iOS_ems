import Foundation
//
//  EMSManager.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import KeychainSwift

final class EMSManager {
    static let shared = EMSManager()
    private let userDefaults: UserDefaults
    private let keychain: KeychainSwift
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private init(userDefaults: UserDefaults = .standard, keychain: KeychainSwift = KeychainSwift()) {
        self.userDefaults = userDefaults
        self.keychain = keychain
    }
    var currentUser: User? {
        guard let data = userDefaults.data(forKey: "loggedUser") else { return nil }
        return try? decoder.decode(User.self, from: data)
    }
    var token: String? {
        keychain.get("user_token")
    }
    var isLoggedIn: Bool {
        userDefaults.bool(forKey: "isUserLoggedIn")
    }
    func login(
        user: User,
        token: String
    ) {
        do {
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: "loggedUser")
            userDefaults.set(true, forKey: "isUserLoggedIn")
            keychain.set(token, forKey: "user_token")
        } catch {
            print("Failed to encode user: \(error)")
        }
    }

    func signOut() {
        keychain.clear()
        userDefaults.set(false, forKey: "isUserLoggedIn")
        userDefaults.removeObject(forKey: "loggedUser")
        if let bundleID = Bundle.main.bundleIdentifier { //Clear all user Defaults
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }

    deinit {
        print("EMSManager deinitialized")
    }
}
