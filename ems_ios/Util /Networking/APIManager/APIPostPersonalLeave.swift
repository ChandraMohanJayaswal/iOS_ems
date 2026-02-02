//
//  APIPostPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 02/02/2026.
//
import Foundation
protocol APIPostPersonalLeave{
    func postPersonalLeave(selectedLeaveType: Int, leaveFromDate: String, leaveToDate: String, description:String) async
}
extension APIPostPersonalLeave{
    func postPersonalLeave(selectedLeaveType: Int, leaveFromDate: String, leaveToDate: String, description: String) async{
        let personalLeaveEnum = EndPointPersonalLeave.postPersonalLeave(lineManagerId: 1, leaveTypeId: selectedLeaveType, leaveFromDate: leaveFromDate, leaveToDate: leaveToDate, description: description, leaveStatusId: 1, leaveStatusComment: "Some Comment")
        let apiClient = DefaultAPIClient<EndPointPersonalLeave>()
        do{
            _ = try await apiClient.request(personalLeaveEnum)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
