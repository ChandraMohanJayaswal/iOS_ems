//
//  LeaveRequestAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 13/01/2026.
//

import Foundation
struct MyPersonalLeaveRequestsAPIResponse: Decodable{
    let data : leaveRequestList?
    enum CodingKeys: CodingKey {
        case data
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = container.decodeSafe(leaveRequestList.self, forKey: .data)
    }
}
struct leaveRequestList: Decodable{
    let leaveRequestList: [leaveRequestObject]?
    enum CodingKeys: String, CodingKey{
        case leaveRequestList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leaveRequestList = container.decodeSafe([leaveRequestObject].self, forKey: .leaveRequestList)
    }
}

struct leaveRequestObject: Decodable, Identifiable{
    let id: Int
    let leaveRequestedDate: String
    let leaveRequestedTime: String
    let leaveFromDate:String
    let leaveToDate:String
    let leaveTypeRes: LeaveType
    let description:String
    let leaveStatusRes: leaveStatusRes
    let statusComment: String
}
struct leaveStatusRes: Decodable{
    let statusType: String
}
