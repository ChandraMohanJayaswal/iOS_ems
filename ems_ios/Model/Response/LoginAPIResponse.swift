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
