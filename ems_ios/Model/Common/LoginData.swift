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
        case token = "token"
        case user = "user"
    }
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do{
            self.token = try container.decodeIfPresent(String.self, forKey: .token)
        }
        catch{
            print("Failed to decode token: ", error.localizedDescription)
            self.token = nil
        }
        
        
        do{
            self.user = try container.decodeIfPresent(User.self, forKey: .user)
        }
        catch{
            print("Failed to decode user: ", error.localizedDescription)
            self.user = nil
        }
    }
}
