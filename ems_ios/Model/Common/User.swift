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
        do {
            self.firstName = try container.decode(String.self, forKey: .firstName)
        }
        catch{
            print("Failed to decode firstName: ", error.localizedDescription)
            self.firstName = nil
        }
        
        do {
            self.lastName = try container.decode(String.self, forKey: .lastName)
        }
        catch{
            print("Failed to decode lastName: ", error.localizedDescription)
            self.lastName = nil
        }
        
        do {
            self.fullName = try container.decode(String.self, forKey: .fullName)
        }
        catch{
            print("Failed to decode fullName: ", error.localizedDescription)
            self.fullName = nil
        }
        
        do {
            self.gender = try container.decode(String.self, forKey: .gender)
        }
        catch{
            print("Failed to decode gender: ", error.localizedDescription)
            self.gender = nil
        }
        
        do {
            self.mobileNumber = try container.decode(String.self, forKey: .mobileNumber)
        }
        catch{
            print("Failed to decode mobileNumber: ", error.localizedDescription)
            self.mobileNumber = nil
        }
        
        do {
            self.emailAddress = try container.decode(String.self, forKey: .emailAddress)
        }
        catch{
            print("Failed to decode emailAddress: ", error.localizedDescription)
            self.emailAddress = nil
        }
        
        do{
            self.role = try container.decode(Role.self, forKey: .role)
        }
        catch{
            print("Failed to decode role: ", error.localizedDescription)
            self.role = nil
        }
    }
}
