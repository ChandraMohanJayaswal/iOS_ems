//
//  EMSManager.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
import KeychainSwift

extension EMSManager {
    enum Keys {
        static let loggedUser = "loggedUser"
        static let userToken = "user_token"
        static let isUserLoggedIn = "isUserLoggedIn"
    }
    enum EMSManagerError: LocalizedError {
        case encodingFailed
        case userNotFound
        case decodingFailed
        case notLoggedIn
        var errorDescription: String? {
            switch self {
            case .encodingFailed:
                return "Failed to encode user data. Please try again."
            case .userNotFound:
                return "User not found in storage."
            case .decodingFailed:
                return "Failed to decode user data. Data may be corrupted."
            case .notLoggedIn:
                return "You must be logged in to perform this action."
            }
        }
        var recoverySuggestion: String? {
            switch self {
            case .encodingFailed:
                return "Check if all user data is valid and try again."
            case .userNotFound:
                return "Please login again to refresh your data."
            case .decodingFailed:
                return "Please logout and login again."
            case .notLoggedIn:
                return "Please login to continue."
            }
        }
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
    func login(user: User, token: String) throws {
        do {
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: Keys.loggedUser)
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
