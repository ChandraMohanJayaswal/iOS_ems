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
    @Published var selectedLeaveType: Int {
        didSet{
            print(selectedLeaveType)
        }
    }
    
    @Published var leaveTypeList: [LeaveTypeAPIResponseList]
    @Published var leaveRequestedDateTime: Date
    @Published var leaveFromDate: Date
    {
        didSet{
            print(leaveFromDate)
        }
    }
    @Published var leaveToDate: Date
    @Published var description: String
    init(){
        self.selectedLineManager = 0
        self.leaveRequestedDateTime = Date()
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
            for item in decoded.data.list{
                leaveTypeList.append(item)
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
