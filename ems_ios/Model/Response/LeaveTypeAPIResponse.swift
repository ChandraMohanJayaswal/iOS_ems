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
        do {
            self.data = try container.decode(LeaveTypeAPIResponseData.self, forKey: .data)
        } catch  {
            print("Failed to decode leave type data: ", error.localizedDescription)
            self.data = nil
        }
    }
}

struct LeaveTypeAPIResponseData: Decodable{
    let leaveTypeList: [LeaveType]?
    enum CodingKeys: String, CodingKey{
        case leaveTypeList  = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.leaveTypeList = try container.decode([LeaveType].self, forKey: .leaveTypeList)
        } catch  {
            print("Failed to decode leave type leaveTypeList: ", error.localizedDescription)
            self.leaveTypeList = nil
        }
    }
}

