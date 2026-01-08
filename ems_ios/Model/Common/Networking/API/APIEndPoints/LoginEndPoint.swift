//
//  LoginEndPoint.swift
//  ems_ios
//
//  Created by MacMini on 08/01/2026.
//
import Foundation
enum LoginEndPoint: APIEndPoint{
    case login(username: String, password:String)
    var baseURL: URL {
        return URL(string: "http://localhost:9090/auth")!
    }
    var path: String {
        switch self {
        case .login:
            return "/login"
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
            return ["username":username, "password": password]
        }
    }
}
