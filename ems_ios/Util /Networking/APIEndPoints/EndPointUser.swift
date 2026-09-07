import Foundation
//
//  EndPointUser.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//
import KeychainSwift

enum EndPointUser: APIEndPoint {
    case getLineManager
    var baseURL: URL {
        return URL(string: AppConfig.baseURL)!
    }

    var path: String {
        switch self {
        case .getLineManager:
            return "/api/user/line-managers"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getLineManager:
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getLineManager:
            return [
                "Authorization":
                    "Bearer \(EMSManager.shared.token ?? "")",
                "Content-Type": "application/json"
            ]
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .getLineManager:
            return nil
        }
    }
}
