//
//  Networking.swift
//  ems_ios
//
//  Created by MacMini on 29/12/2025.
//


import Foundation
import System
import SwiftUI
import KeychainSwift
import Combine
struct LoginResponse:Decodable{
    let status: Bool
    let message: String
    let data: LoginData
}

struct LoginData: Decodable{
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
class NetworkManager: ObservableObject{
    func login(email:String, password:String, completion: @escaping(LoginResponse)->Void) async{
        let url = URL(string:"http://localhost:9090/auth/login")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "username": email,
            "password":password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            print(data)
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            UserDefaults.standard.set(decoded.data.user.firstName, forKey:"firstName")
            UserDefaults.standard.set(decoded.data.user.lastName, forKey:"lastName")
            UserDefaults.standard.set(decoded.data.user.gender, forKey: "gender")
            UserDefaults.standard.set(decoded.data.user.emailAddress, forKey: "emailAddress")
            UserDefaults.standard.set(decoded.data.user.mobileNumber, forKey: "mobileNumber")
            UserDefaults.standard.set(decoded.data.user.role.title, forKey: "title")
            KeychainSwift().set(decoded.data.token, forKey:"user_token")
            completion(decoded)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
