//
//  ViewModelLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import SwiftUI
import Combine
protocol ViewModelLoginServiceProtocol: APILogin{}
final class ViewModelLoginService: ViewModelLoginServiceProtocol{}
class ViewModelLogin: ObservableObject{
    @Published var email:String
    @Published var isAlertShown:Bool
    @Published var password:String
    @Published var isAuthenticated:Bool
    @Published var uiState : UISTATE = .idle
    private let apiService: ViewModelLoginServiceProtocol
    init(apiSerivce: ViewModelLoginServiceProtocol = ViewModelLoginService()){
        self.apiService = apiSerivce
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
        do {
            try await apiService.login(email: self.email, password: self.password)
            self.isAuthenticated = true
        }
        catch{
            print("Authentication failed")
            self.isAuthenticated = false
        }
        self.uiState = .idle
    }
}
