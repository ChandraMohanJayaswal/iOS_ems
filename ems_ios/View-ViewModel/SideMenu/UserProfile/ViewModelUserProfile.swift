//
//  ViewModelUserProfile.swift
//  ems_ios
//
//  Created by MacMini on 26/12/2025.
//

import Foundation
import Combine
enum Gender:String, Identifiable, CaseIterable{
    case Male = "Male"
    case Female = "Female"
    case Others = "Others"
    var id: String { self.rawValue }
}
class ViewModelUserProfile: ObservableObject{
    @Published var role: String
    @Published var firstName: String
    @Published var lastName:String
    @Published var gender: Gender
    @Published var dob:Date
    @Published var mobileNumber:String
    @Published var emailAddress:String
    init(){
        self.role = ""
        self.firstName = ""
        self.lastName = ""
        self.gender = Gender.Male
        self.dob = Date()
        self.mobileNumber = ""
        self.emailAddress = ""
    }
}
