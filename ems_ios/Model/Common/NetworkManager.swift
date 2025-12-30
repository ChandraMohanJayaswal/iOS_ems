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

class NetworkManager: ObservableObject{
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
    struct FiscalYearResponse:Decodable{
        let data: FiscalYearResponseData
    }
    struct FiscalYearResponseData:Decodable{
        let list: [FiscalYear]
    }
    struct FiscalYear:Decodable{
        let fiscalYear:String
    }
    func fetchFiscalYear(completion: @escaping([FiscalYear])-> Void)async{
        let url = URL(string:"http://localhost:9090/api/fiscalYear?pageNumber=0&pageSize=10&sortOrder=ASC&sortBy=id&searchTerm=")!
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(KeychainSwift().get("user_token") ?? "NA")", forHTTPHeaderField: "Authorization")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(FiscalYearResponse.self, from: data)
            completion(decoded.data.list)
        }
        catch{
            print(error.localizedDescription)
        }
    }
 
    func fetchPublicHolidays(completion: @escaping([PublicHolidaysResponseDetails])-> Void) async {
        let url = URL(string: "http://localhost:9090/api/publicHoliday?pageNumber=0&pageSize=10&sortOrder=ASC&sortBy=id&searchTerm=2020" )!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(KeychainSwift().get("user_token") ?? "NA")", forHTTPHeaderField: "Authorization")
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoded = try JSONDecoder().decode(PublicHolidaysResponse.self, from: data)
            completion(decoded.data.list)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
