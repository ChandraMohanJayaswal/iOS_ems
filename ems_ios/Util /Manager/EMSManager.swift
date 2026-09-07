//
//  EMSManager.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
import KeychainSwift

private extension EMSManager {
    enum Keys {
        static let loggedUser = "loggedUser"
        static let userToken = "user_token"
        static let isUserLoggedIn = "isUserLoggedIn"
    }
}

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
        guard let data = userDefaults.data(forKey: Keys.loggedUser) else {
            return nil
        }
        return try? decoder.decode(User.self, from: data)
    }
    var token: String? {
        keychain.get(Keys.userToken)
    }
    var isLoggedIn: Bool {
        userDefaults.bool(forKey: Keys.isUserLoggedIn)
    }
    func login(
        user: User,
        token: String
    ) {
        do {
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: Keys.loggedUser)
            userDefaults.set(true, forKey: Keys.isUserLoggedIn)
            keychain.set(token, forKey: Keys.userToken)
        } catch {
            print("Failed to encode user: \(error)")
        }
    }

    func signOut() {
        keychain.clear()
        userDefaults.set(false, forKey: Keys.isUserLoggedIn)
        userDefaults.removeObject(forKey: Keys.loggedUser)
        if let bundleID = Bundle.main.bundleIdentifier { //Clear all user Defaults
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }

    deinit {
        print("EMSManager deinitialized")
    }
}
