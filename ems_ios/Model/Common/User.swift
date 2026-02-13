//
//  User.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct User: Decodable{
    let firstName:String?
    let lastName:String?
    let fullName: String?
    let gender: String?
    let mobileNumber:String?
    let emailAddress:String?
    let role: Role?
    
    enum CodingKeys: String, CodingKey{
        case firstName = "firstName"
        case lastName = "lastName"
        case fullName = "fullName"
        case gender = "gender"
        case mobileNumber = "mobileNumber"
        case emailAddress = "emailAddress"
        case role = "role"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = container.decodeSafe(String.self, forKey: .firstName)
        lastName = container.decodeSafe(String.self, forKey: .lastName)
        fullName = container.decodeSafe(String.self, forKey: .fullName)
        gender = container.decodeSafe(String.self, forKey: .gender)
        mobileNumber = container.decodeSafe(String.self, forKey: .mobileNumber)
        emailAddress = container.decodeSafe(String.self, forKey: .emailAddress)
        role = container.decodeSafe(Role.self, forKey: .role)
    }
}
