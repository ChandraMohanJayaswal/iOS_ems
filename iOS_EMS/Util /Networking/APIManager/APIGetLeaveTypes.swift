//
//  APIGetLeaveType.swift
//  iOS_EMS
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIGetLeaveTypes {
    func getLeaveType(success: @escaping ([LeaveType]) -> Void, failure: @escaping (Error) -> Void) async
}
extension APIGetLeaveTypes {
    func getLeaveType(success: @escaping ([LeaveType]) -> Void, failure: @escaping (Error) -> Void) async {
        let leaveTypeEnum = EndPointLeaveType.getLeaveTypes
        let apiClient = DefaultAPIClient<EndPointLeaveType>()
        do {
            let data = try await apiClient.request(leaveTypeEnum)
            let decoded = try JSONDecoder().decode(LeaveTypeResponse.self, from: data)
            success(decoded.leaveTypeList ?? [])
        } catch {
            failure(error)
            print(error.localizedDescription)
        }
    }
}
