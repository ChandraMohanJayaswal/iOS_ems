//
//  LoginAPIResponse.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import Foundation

struct LoginResponse:Decodable{
    let status: Bool?
    let message: String?
    let data: LoginData?
    
    enum CodingKeys:String, CodingKey{
        case status = "status"
        case message = "message"
        case data = "data"
    }
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            status = try container.decodeIfPresent(Bool.self, forKey: .status)
        } catch{
            print("Failed to decode status: \(error.localizedDescription)")
            status = nil
        }
        do {
            message = try container.decodeIfPresent(String.self, forKey: .message)
        }
        catch{
            print("Failed to decode message: \(error.localizedDescription)")
            message = nil
        }
        do {
            data = try container.decodeIfPresent(LoginData.self, forKey: .data)
        }
        catch{
            print("Failed to decode data \(error.localizedDescription)")
            data = nil
        }
    }
}
