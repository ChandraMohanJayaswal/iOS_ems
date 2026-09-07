//
//  EndPointWeekend.swift
//  ems_ios
//
//  Created by MacMini on 19/08/2026.
//

import Foundation
import KeychainSwift

enum EndPointWeekend: APIEndPoint {
    case getWeekend
    var baseURL: URL {
        return  URL(string: AppConfig.baseURL)!
    }
    var path: String {
        switch self {
        case .getWeekend:
            return "/api/weekend"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getWeekend:
            return .get
        }
    }
    var headers: [String: String]? {
        switch self {
        case .getWeekend:
            return [
                "Authorization":
                    "Bearer \(UserDefaultsManager.shared.token ?? "")",
                "Content-Type": "application/json"
            ]
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getWeekend:
            return ["all": true]
        }
    }
}
