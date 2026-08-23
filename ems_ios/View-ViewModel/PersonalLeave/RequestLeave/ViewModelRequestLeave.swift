//
//  ViewModel.swift
//  ems_ios
//
//  Created by MacMini on 05/01/2026.
//

import Combine
import Foundation

protocol ViewModelPersonalLeaveServiceProtocol: APIPostPersonalLeave,
    APIGetLeaveType, APIGetLineManagers {}
final class ViewModelRequestLeaveService: ViewModelPersonalLeaveServiceProtocol {}
final class ViewModelRequestLeave: ObservableObject {
    @Published var selectedLineManagers: Set<Int> = []
    @Published var uiState: UISTATE = .idle
    @Published var selectedLeaveType: Int
    @Published var leaveTypes: [LeaveType]
    @Published var leaveFromDate: Date
    @Published var leaveToDate: Date
    @Published var description: String
    @Published var lineManagers: [LineManager] = []
    @Published var leaveCount: Double?
    var isFormValid: Bool {
        selectedLeaveType != 0 && !selectedLineManagers.isEmpty
            && leaveFromDate <= leaveToDate
    }
    private let apiService: ViewModelPersonalLeaveServiceProtocol
    init(
        apiService: ViewModelPersonalLeaveServiceProtocol =
            ViewModelRequestLeaveService()
    ) {
        self.apiService = apiService
        self.selectedLeaveType = 0
        self.leaveFromDate = Date()
        self.leaveToDate = Date()
        self.description = ""
        self.leaveTypes = []
    }
    func getLeaveTypes() async {
        self.uiState = .loading
        self.leaveTypes.removeAll()
        await apiService.getLeaveType { result in
            for item in result {
                self.leaveTypes.append(item)
            }
        }
        self.uiState = .idle
    }
    func postPersonalLeave() async {
        self.uiState = .loading
        print(self.selectedLineManagers)
        await apiService.postPersonalLeave(
            lineManagerIds: Array(self.selectedLineManagers),
            leaveTypeId: self.selectedLeaveType,
            leaveFromDate: formatDateForServer(self.leaveFromDate),
            leaveToDate: formatDateForServer(self.leaveToDate),
            leaveCount: self.leaveCount,
            description: self.description
        )
        self.uiState = .idle
    }
    func getLineManagers() async {
        await apiService.getLineManagers { result in
            self.lineManagers = result
        }
    }
    func formatDateForServer(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var dateString = formatter.string(from: date)
        dateString = dateString.replacingOccurrences(of: "/", with: "-")
        return dateString
    }
}
