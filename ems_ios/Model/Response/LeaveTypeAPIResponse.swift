//
//  LeaveTypeAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 09/01/2026.
//
import Foundation
struct LeaveTypeResponse: Decodable {
    let leaveTypeList: [LeaveType]?
    enum CodingKeys: String, CodingKey {
        case leaveTypeList  = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leaveTypeList = container.decodeSafe([LeaveType].self, forKey: .leaveTypeList)
    }
}
