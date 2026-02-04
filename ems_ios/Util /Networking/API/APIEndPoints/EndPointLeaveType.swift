//
//  LeaveTypeEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//

import Foundation
import KeychainSwift

enum EndPointLeaveType: APIEndPoint{
    case getLeaveTypes
    var baseURL: URL {
        URL(string:AppConfig.baseURL)!
    }
    var path: String{
        switch self{
        case .getLeaveTypes:
            return "/api/leaveType"
        }
    }
    var method: HTTPMethod{
        switch self{
        case .getLeaveTypes:
            return .get
        }
    }
    var headers: [String : String]?{
        switch self{
        case .getLeaveTypes:
            return ["Authorization": "Bearer \(KeychainSwift().get("user_token")!)"]

        }
    }
    var parameters: [String: Any]?{
        switch self{
        case .getLeaveTypes:
            return nil
        }
    }
}
