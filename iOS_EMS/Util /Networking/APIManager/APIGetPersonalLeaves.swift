//
//  GetMyLeaveRequests.swift
//  iOS_EMS
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
protocol APIGetPersonalLeaves {
    func getPersonalLeaves(success: @escaping ([PersonalLeave]) -> Void, failure: @escaping (Error) -> Void)async
}
extension APIGetPersonalLeaves {
    func getPersonalLeaves(success: @escaping ([PersonalLeave]) -> Void, failure: @escaping (Error) -> Void) async {
        let leaveRequestEnum = EndPointPersonalLeave.getPersonalLeave
        let apiClient = DefaultAPIClient<EndPointPersonalLeave>()
        do {
            let data = try await apiClient.request(leaveRequestEnum)
            let decoded = try JSONDecoder().decode(PersonalLeaveResponse.self, from: data)
            success(decoded.leaveRequestList ?? [])
        } catch {
            failure(error)
        }

    }
}
