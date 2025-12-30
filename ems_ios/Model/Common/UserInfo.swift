//
//  UserInfo.swift
//  ems_ios
//
//  Created by MacMini on 29/12/2025.
//

import Foundation
import Combine
class UserInfo: ObservableObject{
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
