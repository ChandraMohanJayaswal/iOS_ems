//
//  LeaveRequestAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 13/01/2026.
//

import Foundation
struct MyPersonalLeaveRequestsAPIResponse: Decodable {
    let data: LeaveRequestList?
    enum CodingKeys: CodingKey {
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = container.decodeSafe(LeaveRequestList.self, forKey: .data)
    }
}
struct LeaveRequestList: Decodable {
    let leaveRequestList: [LeaveRequestObject]?
    enum CodingKeys: String, CodingKey {
        case leaveRequestList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leaveRequestList = container.decodeSafe([LeaveRequestObject].self, forKey: .leaveRequestList)
    }
}

struct LeaveRequestObject: Decodable, Identifiable {
    let id: Int
    let leaveRequestedDate: String
    let leaveRequestedTime: String
    let leaveFromDate: String
    let leaveToDate: String
    let leaveTypeRes: LeaveType
    let description: String
    let leaveStatusRes: LeaveStatusRes
    let statusComment: String
}
struct LeaveStatusRes: Decodable {
    let statusType: String
}
