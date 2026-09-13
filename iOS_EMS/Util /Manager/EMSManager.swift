//
//  EMSManager.swift
//  iOS_EMS
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
import KeychainSwift

final class EMSManager {
    static let shared = EMSManager()
    private let userDefaults: UserDefaults
    private let keychain: KeychainSwift
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    init(userDefaults: UserDefaults = .standard, keychain: KeychainSwift = KeychainSwift()) {
        self.userDefaults = userDefaults
        self.keychain = keychain
    }
    var loggedUser: User? {
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
    func login(user: User, token: String) throws {
        do {
            let loggedUser = try encoder.encode(user)
            userDefaults.set(loggedUser, forKey: Keys.loggedUser)
            userDefaults.set(true, forKey: Keys.isUserLoggedIn)
            keychain.set(token, forKey: Keys.userToken)
        } catch {
            throw EMSManagerError.encodingFailed
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
