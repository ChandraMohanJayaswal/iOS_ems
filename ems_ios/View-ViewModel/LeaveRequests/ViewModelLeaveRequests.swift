//
//  ViewModelLeaveRequests.swift
//  ems_ios
//
//  Created by MacMini on 13/01/2026.
//

import Foundation
import Combine
class ViewModelLeaveRequests: ObservableObject {
    @Published var leaveRequests:  [leaveRequestObject]
    init()
    {
        self.leaveRequests = []
    }
    func fetchMyLeaveRequestsFromServer() async{
        let leaveRequestEnum = EndPointPersonalLeave.getPersonalLeave
        let apiClient = DefaultAPIClient<EndPointPersonalLeave>()
        do {
            let data = try await apiClient.request(leaveRequestEnum)
            let decoded = try JSONDecoder().decode(MyPersonalLeaveRequestsAPIResponse.self, from: data)
            self.leaveRequests = decoded.data?.leaveRequestList ?? []
        } catch  {
            print("Server Error", error.localizedDescription)
        }
    }
}
