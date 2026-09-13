//
//  Keys.swift
//  iOS_EMS
//
//  Created by Chandra Jayaswal on 13/09/2026.
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