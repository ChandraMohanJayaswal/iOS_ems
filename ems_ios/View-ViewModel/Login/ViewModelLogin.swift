//
//  ViewModelLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import Combine
import SwiftUI
import KeychainSwift
class ViewModelLogin: ObservableObject{
    @Published var email:String
    @Published var isAlertShown:Bool
    @Published var password:String
    @Published var isAuthenticated:Bool
    @Published var uiState : UISTATE = .idle
    init(){
        self.email = ""
        self.password = ""
        self.isAuthenticated = false
        self.isAlertShown = false
    }
    var isFormValid: Bool{
        return !email.isEmpty && !password.isEmpty
    }
    func login() async {
        self.uiState = .loading
        let loginEnum = EndPointLogin.login(username: self.email, password: self.password)
        let apiClient = DefaultAPIClient<EndPointLogin>()
        do {
            let data = try await apiClient.request(loginEnum)
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            UserDefaults.standard.set(decoded.data?.user?.firstName, forKey:"firstName")
            UserDefaults.standard.set(decoded.data?.user?.lastName, forKey:"lastName")
            UserDefaults.standard.set(decoded.data?.user?.gender, forKey: "gender")
            UserDefaults.standard.set(decoded.data?.user?.emailAddress, forKey: "emailAddress")
            UserDefaults.standard.set(decoded.data?.user?.mobileNumber, forKey: "mobileNumber")
            UserDefaults.standard.set(decoded.data?.user?.role?.title, forKey: "title")
            if let token = decoded.data?.token{
                KeychainSwift().set(token, forKey:"user_token")
            }
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            self.isAuthenticated = true

        }
        catch{
            print(error.localizedDescription)
        }
        self.uiState = .idle
    }
}
