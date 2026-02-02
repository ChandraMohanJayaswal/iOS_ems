//
//  GetMyLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
protocol APIGetMyLeaveRequests{
    func getMyLeaveRequests(completion: @escaping([leaveRequestObject]) -> Void)async
}
extension APIGetMyLeaveRequests{
    func getMyLeaveRequests(completion: @escaping([leaveRequestObject]) -> Void) async{
        let leaveRequestEnum = EndPointPersonalLeave.getPersonalLeave
        let apiClient = DefaultAPIClient<EndPointPersonalLeave>()
        do {
            let data = try await apiClient.request(leaveRequestEnum)
            let decoded = try JSONDecoder().decode(MyPersonalLeaveRequestsAPIResponse.self, from: data)
            completion(decoded.data?.leaveRequestList ?? [])
        } catch  {
            print("Server Error", error.localizedDescription)
        }

    }
}
