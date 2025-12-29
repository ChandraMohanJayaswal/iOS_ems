//
//  ViewModelLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import Foundation
import Combine
class ViewModelLogin: ObservableObject{
    @Published var email:String
    @Published var password:String
    init(){
        self.email = ""
        self.password = ""
    }
    var isFormValid: Bool{
        return !email.isEmpty && !password.isEmpty
    }
}
