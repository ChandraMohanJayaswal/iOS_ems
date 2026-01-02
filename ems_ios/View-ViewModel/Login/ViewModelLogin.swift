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
    @Published var password:String
    @Published var isAuthenticated:Bool = false
    init(){
        self.email = ""
        self.password = ""
    }
    var isFormValid: Bool{
        return !email.isEmpty && !password.isEmpty
    }
    func login() async{
        let manager = NetworkManager()
        await manager.login(email: self.email, password: self.password) { data in
            if data.status == true{
                self.isAuthenticated = true
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
            }
        }
    }
}
