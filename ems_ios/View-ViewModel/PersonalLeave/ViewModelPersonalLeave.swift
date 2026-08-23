//
//  ViewModelPersonalLeave.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//
import SwiftUI
import Combine
class ViewModelPersonalLeave: ObservableObject {
    @Published var leaveRequests: [LeaveRequest] = []
    private let apiService: ViewModelLeaveRequestsServiceProtocol
    init(apiService: ViewModelLeaveRequestsServiceProtocol = ViewModelLeaveRequestsService() ) {
        self.apiService = apiService
    }
    func getLeaveRequests() async {
        await apiService.getMyLeaveRequests { leaveRequests in
            self.leaveRequests = leaveRequests
        }
    }
}
