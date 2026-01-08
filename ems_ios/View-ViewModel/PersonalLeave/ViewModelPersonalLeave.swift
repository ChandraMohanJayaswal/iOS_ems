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
    @Published var selectedLeaveType: Int
    @Published var leaveRequestedDateTime: Date
    @Published var leaveFromDate: Date
    @Published var leaveToDate: Date
    @Published var description: String
    init(){
        self.selectedLineManager = 0
        self.selectedLeaveType = 0
        self.leaveRequestedDateTime = Date()
        self.leaveFromDate = Date()
        self.leaveToDate = Date()
        self.description = ""
    }
}
