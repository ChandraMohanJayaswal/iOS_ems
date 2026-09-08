//
//  LeaveRequestAPIResponse.swift
//  iOS_EMS
//
//  Created by MacMini on 13/01/2026.
//

import Foundation
import SwiftUI
struct PersonalLeaveResponse: Decodable {
    let leaveRequestList: [PersonalLeave]?
    enum CodingKeys: String, CodingKey {
        case leaveRequestList = "list"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        leaveRequestList = container.decodeSafe([PersonalLeave].self, forKey: .leaveRequestList)
    }
}

struct PersonalLeave: Decodable, Identifiable {
    let id: Int
    let leaveFromDate: Double?
    let createdEpoch: Double?
    let leaveToDate: Double?
    let leaveTypeRes: LeaveType?
    let description: String?
    let leaveStatusRes: LeaveStatusRes?
    let statusComment: String?
    enum CodingKeys: String, CodingKey {
        case id
        case leaveFromDate
        case createdEpoch = "createdDateTime"
        case leaveToDate
        case leaveTypeRes
        case description
        case leaveStatusRes
        case statusComment
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = container.decodeSafe(Int.self, forKey: .id) ?? 0
        self.leaveFromDate = container.decodeSafe(Double.self, forKey: .leaveFromDate)
        self.createdEpoch = container.decodeSafe(Double.self, forKey: .createdEpoch)
        self.leaveToDate = container.decodeSafe(Double.self, forKey: .leaveToDate)
        self.leaveTypeRes = container.decodeSafe(LeaveType.self, forKey: .leaveTypeRes)
        self.description = container.decodeSafe(String.self, forKey: .description)
        self.leaveStatusRes = container.decodeSafe(LeaveStatusRes.self, forKey: .leaveStatusRes)
        self.statusComment = container.decodeSafe(String.self, forKey: .statusComment)
    }
}
struct LeaveStatusRes: Decodable {
    let statusType: LeaveStatusType?
    enum CodingKeys: String, CodingKey {
        case statusType
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.statusType = container.decodeSafe(LeaveStatusType.self, forKey: .statusType)
    }
}

enum LeaveStatusType: String, Codable, CaseIterable {
    case all = "ALL"
    case pending = "PENDING"
    case approved = "APPROVED"
    case rejected = "REJECTED"
}
