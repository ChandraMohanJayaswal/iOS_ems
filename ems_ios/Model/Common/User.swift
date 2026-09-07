//
//  User.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct User: Codable { // Codable = Decodable + Encodable
    let id: Int?
    let firstName: String?
    let lastName: String?
    let fullName: String?
    let gender: String?
    let mobileNumber: String?
    let emailAddress: String?
    let role: Role?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName
        case lastName
        case fullName
        case gender
        case mobileNumber
        case emailAddress
        case role
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
        id = container.decodeSafe(Int.self, forKey: .id)
    }
    
    // Add custom encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(fullName, forKey: .fullName)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(mobileNumber, forKey: .mobileNumber)
        try container.encodeIfPresent(emailAddress, forKey: .emailAddress)
        try container.encodeIfPresent(role, forKey: .role)
    }

}
