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
    @Published var dob:Date
    @Published var gender: Gender
    @Published var mobileNumber:String
    @Published var emailAddress:String
    init() {
        self.role = UserDefaults.standard.string(forKey: "title") ?? "NA"
        self.firstName = UserDefaults.standard.string(forKey:"firstName") ?? "NA"
        self.lastName = UserDefaults.standard.string(forKey:"lastName") ?? "NA"
        self.gender = UserDefaults.standard.string(forKey:"gender") == "MALE" ? .Male : .Female
        self.dob = Date()
        self.mobileNumber = UserDefaults.standard.string(forKey: "mobileNumber") ?? "NA"
        self.emailAddress = UserDefaults.standard.string(forKey: "emailAddress") ?? "NA"
    }
//    func login() async{
//        await networkManager.login{ data in
//            self.firstName = data.data.user.firstName
//        }
//    }
}
