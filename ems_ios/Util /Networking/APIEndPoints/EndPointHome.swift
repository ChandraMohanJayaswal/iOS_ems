//
//  EndPointHome.swift
//  ems_ios
//
//  Created by MacMini on 06/09/2026.
//
import KeychainSwift
import Foundation
enum EndPointHome: APIEndPoint {
    case getMetrics
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
        case .getMetrics:
            return ["Authorization": "Bearer \(EMSManager.shared.token ?? " ")"]

        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .getMetrics:
            return ["userId": EMSManager.shared.currentUser?.id ?? 0]
        }
    }
}
