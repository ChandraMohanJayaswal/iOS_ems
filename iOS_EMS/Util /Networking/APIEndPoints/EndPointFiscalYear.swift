//
//  FiscalYearEndPoint.swift
//  iOS_EMS
//
//  Created by MacMini on 08/01/2026.
//
import KeychainSwift
import Foundation

enum EndPointFiscalYear: APIEndPoint {
    case getFiscalYear
    case getPublicHoliday
    var baseURL: URL {
        return URL(string: AppConfig.baseURL)!
    }
    var path: String {
        switch self {
        case .getFiscalYear:
            return "/api/fiscalYear"
        case .getPublicHoliday:
            return "/api/publicHoliday"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getFiscalYear, .getPublicHoliday:
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
        case .getFiscalYear:
            return nil
        case .getPublicHoliday:
            return ["all": true]
        }
    }
}
