//
//  FiscalYearEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import KeychainSwift
import Foundation
enum FiscalYearEndPoint: APIEndPoint{
    case getFiscalYear
    case getPublicHoliday
    var baseURL: URL{
        return URL(string:"http://localhost:9090/api")!
    }
    var path: String{
        switch self{
        case .getFiscalYear:
            return "/fiscalYear"
        case .getPublicHoliday:
            return "/publicHoliday"
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
