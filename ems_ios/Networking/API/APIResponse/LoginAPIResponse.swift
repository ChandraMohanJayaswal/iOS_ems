//
//  LoginAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import Foundation
struct LoginResponse:Decodable{
let status: Bool
let message: String
let data: LoginData
}

struct LoginData: Decodable {
    let token: String
    let user: User
}

struct User: Decodable{
    let firstName:String
    let lastName:String
    let fullName: String
    let gender: String
    let mobileNumber:String
    let emailAddress:String
    let role: Role
}

struct Role: Decodable{
    let title: String
}
