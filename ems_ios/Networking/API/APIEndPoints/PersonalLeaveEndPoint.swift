//
//  PersonalLeaveEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//
import Foundation
import KeychainSwift
enum PersonalLeaveEndPoint: APIEndPoint {
    case postPersonalLeave(lineManagerId: Int, leaveTypeId: Int, leaveFromDate: String, leaveToDate: String, description: String, leaveStatusId: Int, leaveStatusComment: String)
    var baseURL: URL{
        return URL(string: "http://localhost:9090/api")!
    }
    var path: String{
        switch self{
        case .postPersonalLeave:
           return "/personalLeave"
        }
    }
    var method: HTTPMethod{
        switch self{
        case .postPersonalLeave:
            return .post
        }
    }
    var headers: [String : String]?{
        switch self{
        case .postPersonalLeave:
            return ["Authorization": "Bearer \(KeychainSwift().get("user_token")!)",
                    "Content-Type": "application/json"]
        }
    }
    var parameters: [String : Any]?{
        switch self{
        case .postPersonalLeave(let lineManagerId, let leaveTypeId, let leaveFromDate, let leaveToDate, let description, let leaveStatusId, let leaveStatusComment):
            return [
                "id" : 0,
                "lineManagerId": lineManagerId,
                "leaveTypeId": leaveTypeId,
                "leaveRequestedDate": "2020-03-23",
                "leaveRequestedTime": "08:30",
                "leaveFromDate": leaveFromDate,
                "leaveToDate": leaveToDate,
                "description": description,
                "leaveStatusId": leaveStatusId,
                "statusComment": leaveStatusComment
            ]
        }
    }
}
