//
//  Networking.swift
//  ems_ios
//
//  Created by MacMini on 29/12/2025.
//


import Foundation
import System
struct AuthAPI{
    static func login()async{
        let url = URL(string:"http://localhost:9090/auth/login")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = [
            "username": "sa@yopmail.com",
            "password": "password"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            print(data)
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            print("STATUS:", decoded.status)
            print("MESSAGE:", decoded.message)
            print("TOKEN:", decoded.data.token)

        }
        catch{
            print(error.localizedDescription)
        }
    }
}
struct LoginResponse:Decodable{
    let status: Bool
    let message: String
    let data: LoginData
}
struct LoginData: Decodable{
    let token: String
}

//class NetworkManager:ObservableObject{
//    @Published isLoggedIn:Bool = false{
//        init(){
//        }
//}
