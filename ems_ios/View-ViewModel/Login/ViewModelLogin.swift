//
//  ViewModelLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Combine
import Foundation
import SwiftUI

protocol ViewModelLoginServiceProtocol: APILogin {}
final class ViewModelLoginService: ViewModelLoginServiceProtocol {}
final class ViewModelLogin: ObservableObject {
    @Published var email: String
    @Published var isAlertShown: Bool
    @Published var password: String
    @Published var showPassword: Bool
    @Published var isAuthenticated: Bool
    @Published var uiState: UISTATE = .idle
    private let apiService: ViewModelLoginServiceProtocol
    @Published var errorOccured: Bool
    @Published var errorMessage: String
    var isFormValid: Bool {
        return email.contains("@") && password.count >= 8
    }
    init(apiService: ViewModelLoginServiceProtocol = ViewModelLoginService()) {
        self.apiService = apiService
        self.email = ""
        self.password = ""
        self.isAuthenticated = false
        self.isAlertShown = false
        self.showPassword = false
        self.errorMessage = ""
        self.errorOccured = false
    }
    func login() async {
        self.uiState = .loading
        await apiService.login(
            email: self.email, password: self.password,
            success: {
                print("Successfully autheticated")
            },
            failure: { [weak self] message in
                print(message)
                self?.errorOccured = true
                self?.errorMessage = message
            })
        self.uiState = .idle
    }
}
