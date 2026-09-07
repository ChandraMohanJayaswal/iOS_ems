//
//  ViewModelUserProfile.swift
//  ems_ios
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
        self.role = UserDefaultsManager.shared.currentUser?.role?.title ?? "NA"
        self.firstName = UserDefaultsManager.shared.currentUser?.firstName ?? "NA"
        self.lastName = UserDefaultsManager.shared.currentUser?.lastName ?? "NA"
        self.gender = UserDefaultsManager.shared.currentUser?.gender == "MALE" ? .male : .female
        self.dob = Date()
        self.mobileNumber = UserDefaultsManager.shared.currentUser?.mobileNumber ?? "NA"
        self.emailAddress = UserDefaultsManager.shared.currentUser?.emailAddress ?? "NA"
    }
}
