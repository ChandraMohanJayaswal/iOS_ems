//
//  LoginData.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct LoginData: Decodable {
    let token: String
    let user: User
}
