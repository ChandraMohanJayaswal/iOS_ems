//
//  User.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct User: Decodable{
    let firstName:String
    let lastName:String
    let fullName: String
    let gender: String
    let mobileNumber:String
    let emailAddress:String
    let role: Role
}
