//
//  LoginFailureResponse.swift
//  ems_ios
//
//  Created by MacMini on 15/05/2026.
//
struct LoginFailureResponse: Codable {
    let message: String?
    let status: String?
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = container.decodeSafe(String.self, forKey: .message)
        self.status = container.decodeSafe(String.self, forKey: .status)
    }
}
