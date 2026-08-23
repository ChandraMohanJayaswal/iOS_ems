//
//  APIPostPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation

protocol APIPostPersonalLeave {
    func postPersonalLeave(
        lineManagerIds: [Int],
        leaveTypeId: Int,
        leaveFromDate: String,
        leaveToDate: String,
        leaveCount: Double?,
        description: String,
    ) async
}
extension APIPostPersonalLeave {
    func postPersonalLeave(
        lineManagerIds: [Int],
        leaveTypeId: Int,
        leaveFromDate: String,
        leaveToDate: String,
        leaveCount: Double?,
        description: String,
    ) async {
        print("Line manager ids:=>", lineManagerIds)
        let personalLeaveEnum = EndPointPersonalLeave.postPersonalLeave(
            lineManagerId: lineManagerIds,
            leaveTypeId: leaveTypeId,
            leaveFromDate: leaveFromDate,
            leaveToDate: leaveToDate,
            leaveCount: leaveCount,
            description: description,
        )
        let apiClient = DefaultAPIClient<EndPointPersonalLeave>()
        do {
            _ = try await apiClient.request(personalLeaveEnum)
        } catch {
            print(error.localizedDescription)
        }
    }
}
