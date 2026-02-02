//
//  ViewModel.swift
//  ems_ios
//
//  Created by MacMini on 05/01/2026.
//

import Foundation
import Combine
protocol ViewModelPersonalLeaveServiceProtocol: APIPostPersonalLeave, APIGetLeaveType{}
final class ViewModelPersonalLeaveService: ViewModelPersonalLeaveServiceProtocol{}
final class ViewModelPersonalLeave: ObservableObject{
    @Published var selectedLineManager: Int
    @Published var uiState: UISTATE = .idle
    @Published var selectedLeaveType: Int
    @Published var leaveTypeList: [LeaveType]
    @Published var leaveFromDate: Date
    @Published var leaveToDate: Date
    @Published var description: String
    private let apiService: ViewModelPersonalLeaveServiceProtocol
    init(apiService: ViewModelPersonalLeaveServiceProtocol = ViewModelPersonalLeaveService()){
        self.apiService = apiService
        self.selectedLineManager = 0
        self.selectedLeaveType = 0
        self.leaveFromDate = Date()
        self.leaveToDate = Date()
        self.description = ""
        self.leaveTypeList = []
    }
    func fetchLeaveTypeFromServer()async{
        self.uiState = .loading
        self.leaveTypeList.removeAll()
        await apiService.getLeaveType { result in
            for item in result{
                self.leaveTypeList.append(item)
            }
        }
        self.uiState = .idle
    }
    func postPersonalLeaveToServer() async{
        self.uiState = .loading
        await apiService.postPersonalLeave(selectedLeaveType: self.selectedLeaveType, leaveFromDate: formatDateForServer(self.leaveFromDate), leaveToDate: formatDateForServer(self.leaveToDate), description: self.description)
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
