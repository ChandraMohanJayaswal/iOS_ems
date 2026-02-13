//
//  LoginData.swift
//  ems_ios
//
//  Created by Chandra Jayaswal on 12/01/2026.
//

import Foundation

struct LoginData: Decodable {
    let token: String?
    let user: User?
    
    enum CodingKeys: String, CodingKey{
        case token
        case user
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = container.decodeSafe(String.self, forKey: .token)
        user = container.decodeSafe(User.self, forKey: .user)
    }
}
