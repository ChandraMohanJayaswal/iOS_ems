//
//  LoginEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import Foundation

enum EndPointLogin: APIEndPoint{
    case login(username: String, password:String)
    var baseURL: URL {
        return URL(string: AppConfig.baseURL)!
    }
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        }
    }
    var method: HTTPMethod{
        switch self {
        case .login:
            return .post
        }
    }
    var headers: [String: String]? {
        switch self {
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
     
    var parameters: [String: Any]? {
        switch self {
        case .login(let username, let password):
            return ["username": username, "password": password]
        }
    }
}
