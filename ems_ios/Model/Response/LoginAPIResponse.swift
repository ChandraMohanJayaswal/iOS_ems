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
        status = container.decodeSafe(Bool.self, forKey: .status)
        message = container.decodeSafe(String.self, forKey: .message)
        data = container.decodeSafe(LoginData.self, forKey: .data)
    }
}
