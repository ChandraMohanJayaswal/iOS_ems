//
//  ViewModelLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 13/01/2026.
//

import Foundation
import Combine
protocol ViewModelLeaveRequestsServiceProtocol: APIGetMyLeaveRequests{}

final class ViewModelLeaveRequestsService: ViewModelLeaveRequestsServiceProtocol{}

class ViewModelLeaveRequests: ObservableObject {
    @Published var leaveRequests:  [leaveRequestObject]
    private let apiService: ViewModelLeaveRequestsServiceProtocol
    init(apiService: ViewModelLeaveRequestsServiceProtocol = ViewModelLeaveRequestsService() )
    {
        self.apiService = apiService
        self.leaveRequests = []
    }
    func fetchMyLeaveRequestsFromServer() async{
        await apiService.getMyLeaveRequests{ leaveRequests in
            self.leaveRequests = leaveRequests
        }
    }
}
