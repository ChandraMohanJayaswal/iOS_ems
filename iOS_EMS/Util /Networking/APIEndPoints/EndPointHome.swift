//
//  EndPointHome.swift
//  iOS_EMS
//
//  Created by MacMini on 06/09/2026.
//
import KeychainSwift
import Foundation
enum EndPointHome: APIEndPoint {
    case getMetrics(month: Int?)
    var baseURL: URL {
        URL(string: AppConfig.baseURL)!
    }
    var path: String {
        switch self {
        case .getMetrics:
            return "/api/home/dashboard_metrics"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getMetrics:
            return .get
        }
    }
    var headers: [String: String]? {
        switch self {
        default:
            return nil

        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getMetrics(let month):
            if let month = month {
                return ["userId": EMSManager.shared.currentUser?.id ?? 0, "month": month]
            } else {
                return ["userId": EMSManager.shared.currentUser?.id ?? 0]
            }
        }
    }
}
