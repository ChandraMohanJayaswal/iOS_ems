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
        self.role = EMSManager.shared.loggedUser?.role?.title ?? "NA"
        self.firstName = EMSManager.shared.loggedUser?.firstName ?? "NA"
        self.lastName = EMSManager.shared.loggedUser?.lastName ?? "NA"
        self.gender = EMSManager.shared.loggedUser?.gender == "MALE" ? .male : .female
        self.dob = Date()
        self.mobileNumber = EMSManager.shared.loggedUser?.mobileNumber ?? "NA"
        self.emailAddress = EMSManager.shared.loggedUser?.emailAddress ?? "NA"
    }

    deinit {
        print("ViewModelUserProfile deinitialized")
    }
}
