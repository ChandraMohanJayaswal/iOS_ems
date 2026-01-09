//
//  LeaveTypeEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//

import Foundation
import KeychainSwift
enum LeaveTypeEndPoint: APIEndPoint{
    case getLeaveTypes
    var baseURL: URL {
      URL(string:"http://localhost:9090/api")!
    }
    var path: String{
        switch self{
        case .getLeaveTypes:
            return "/leaveType"
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
