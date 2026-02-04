//
//  FiscalYearEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import KeychainSwift
import Foundation

enum EndPointFiscalYear: APIEndPoint{
    case getFiscalYear
    case getPublicHoliday
    var baseURL: URL{
        return URL(string: AppConfig.baseURL)!
    }
    var path: String{
        switch self{
        case .getFiscalYear:
            return "/api/fiscalYear"
        case .getPublicHoliday:
            return "/api/publicHoliday"
        }
    }
    var method: HTTPMethod{
        switch self{
        case .getFiscalYear, .getPublicHoliday:
            return .get
        }
    }
    var headers: [String: String]? {
        switch self{
        case .getFiscalYear, .getPublicHoliday:
            return ["Authorization": "Bearer \(KeychainSwift().get("user_token")!)"]
        }
    }
    var parameters: [String: Any]?{
        switch self{
        case .getFiscalYear, .getPublicHoliday:
            return nil
        }
    }
}
