//
//  ViewModel.swift
//  ems_ios
//
//  Created by MacMini on 05/01/2026.
//

import Foundation
import Combine
class ViewModelPersonalLeave: ObservableObject{
    @Published var selectedLineManager: Int
    @Published var uiState: UISTATE = .idle
    @Published var selectedLeaveType: Int {
        didSet{
            print(selectedLeaveType)
        }
    }
    
    @Published var leaveTypeList: [LeaveType]
    @Published var leaveFromDate: Date
    {
        didSet{
            print(leaveFromDate.formatted(date: .numeric, time: .omitted))
        }
    }
    @Published var leaveToDate: Date
    @Published var description: String
    init(){
        self.selectedLineManager = 0
        self.selectedLeaveType = 0
        self.leaveFromDate = Date()
        self.leaveToDate = Date()
        self.description = ""
        self.leaveTypeList = []
    }
    func fetchLeaveTypeFromServer()async{
        leaveTypeList.removeAll()
        let leaveTypeEnum = LeaveTypeEndPoint.getLeaveTypes
        let apiClient = DefaultAPIClient<LeaveTypeEndPoint>()
        do{
            
            let data = try await apiClient.request(leaveTypeEnum)
            let decoded = try JSONDecoder().decode(LeaveTypeAPIResponse.self, from: data)
            for item in decoded.data?.leaveTypeList ?? []{
                leaveTypeList.append(item)
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func postPersonalLeaveToServer() async{
        self.uiState = .loading
        let personalLeaveEnum = PersonalLeaveEndPoint.postPersonalLeave(lineManagerId: 1, leaveTypeId: self.selectedLeaveType, leaveFromDate: formatDateForServer(self.leaveFromDate), leaveToDate: formatDateForServer(self.leaveToDate), description: self.description, leaveStatusId: 1, leaveStatusComment: "Some Comment")
        let apiClient = DefaultAPIClient<PersonalLeaveEndPoint>()
        do{
            _ = try await apiClient.request(personalLeaveEnum)
        }
        catch{
            print(error.localizedDescription)
        }
        self.uiState = .idle
    }
    func formatDateForServer(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var dateString  = formatter.string(from: date)
        dateString = dateString.replacingOccurrences(of: "/", with: "-")
        return dateString
    }
}
