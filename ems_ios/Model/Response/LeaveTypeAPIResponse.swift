//
//  LeaveTypeAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//
import Foundation
struct LeaveTypeAPIResponse: Decodable{
    let data: LeaveTypeAPIResponseData?
    enum CodingKeys: String, CodingKey{
        case data = "data"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = container.decodeSafe(LeaveTypeAPIResponseData.self, forKey: .data)
    }
}

struct LeaveTypeAPIResponseData: Decodable{
    let leaveTypeList: [LeaveType]?
    enum CodingKeys: String, CodingKey{
        case leaveTypeList  = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leaveTypeList = container.decodeSafe([LeaveType].self, forKey: .leaveTypeList)
    }
}

