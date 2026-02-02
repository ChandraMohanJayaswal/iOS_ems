//
//  APIGetLeaveType.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIGetLeaveType{
    func getLeaveType(completion: @escaping([LeaveType]) -> Void)async
}
extension APIGetLeaveType{
    func getLeaveType(completion: @escaping([LeaveType]) -> Void)async{
        let leaveTypeEnum = EndPointLeaveType.getLeaveTypes
        let apiClient = DefaultAPIClient<EndPointLeaveType>()
        do{
            
            let data = try await apiClient.request(leaveTypeEnum)
            let decoded = try JSONDecoder().decode(LeaveTypeAPIResponse.self, from: data)
            completion(decoded.data?.leaveTypeList ?? [])
        }
        catch{
            print(error.localizedDescription)
        }

    }
}
