//
//  ViewModelUserProfile.swift
//  iOS_EMS
//
//  Created by MacMini on 26/12/2025.
//

import Foundation
import Combine
enum Gender: String, Identifiable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case others = "Others"
    var id: String { self.rawValue }
}
class ViewModelUserProfile: ObservableObject {
    @Published var role: String
    @Published var firstName: String
    @Published var lastName: String
    @Published var dob: Date
    @Published var gender: Gender
    @Published var mobileNumber: String
    @Published var emailAddress: String
    @Published var isSheetShown: Bool = false
    init() {
        self.role = EMSManager.shared.currentUser?.role?.title ?? "NA"
        self.firstName = EMSManager.shared.currentUser?.firstName ?? "NA"
        self.lastName = EMSManager.shared.currentUser?.lastName ?? "NA"
        self.gender = EMSManager.shared.currentUser?.gender == "MALE" ? .male : .female
        self.dob = Date()
        self.mobileNumber = EMSManager.shared.currentUser?.mobileNumber ?? "NA"
        self.emailAddress = EMSManager.shared.currentUser?.emailAddress ?? "NA"
    }

    deinit {
        print("ViewModelUserProfile deinitialized")
    }
}
