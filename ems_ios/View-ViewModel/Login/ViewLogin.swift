//
//  ViewLogin.swift
//  Falchaa
//
//  Created by MacMini on 25/12/2025.
//

import SwiftUI

struct ViewLogin: View {
    @State var showPassword:Bool = false
    @StateObject var viewModel = ViewModelLogin()
    @FocusState var emailIsFocused: Bool
    @FocusState var passwordIsFocused: Bool
    @EnvironmentObject var coordinator : RouteCoordinator
    @State private var isAlertShown: Bool = false
    var body: some View {
        Text("EMS Login")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundStyle(.blue)
            .padding()
        Spacer()
        Image("employeeLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        TextField("Email", text: $viewModel.email)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(emailIsFocused ? COLOR_BLUE : COLOR_GRAY.opacity(0.5))
            ).focused($emailIsFocused)
            .padding()
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
        ZStack(alignment:.trailing){
            if showPassword{
                TextField("Password", text: $viewModel.password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(passwordIsFocused ? COLOR_BLUE : COLOR_GRAY.opacity(0.5))
                    )
                    .focused($passwordIsFocused)
                    .autocorrectionDisabled(true)
            }
            else {
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .autocorrectionDisabled(true)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(passwordIsFocused ? COLOR_BLUE : COLOR_GRAY.opacity(0.5))
                    )
                    .focused($passwordIsFocused)
            }
            Button{
                showPassword.toggle()
            } label:{
                Image(systemName:showPassword ? "eye": "eye.slash")
                    .renderingMode(.original)
            }
            .padding()
        }
        .padding()
        Button{
            Task{
                await viewModel.login()
                if viewModel.isAuthenticated{
                coordinator.navigate(to:.tabbar)
                }
            else {
                isAlertShown = true
                }
            }
            
            
        } label:{
            Text("Login")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(viewModel.isFormValid ?
                    Color.blue.gradient : Color.gray.gradient)
                .cornerRadius(12)
        }
        .alert(isPresented:$isAlertShown) {
            Alert(title: Text("Error"), message: Text("Invalid Credentials"), dismissButton: .default(Text("OK")))
        }
        .padding()
            .padding(.bottom, 40)
            .disabled(!viewModel.isFormValid)
        Button{
        } label:{
            Text("Don't have an account")
                .underline()
                .foregroundStyle(Color.blue.gradient)
        }
        Spacer()
        
    }
        
}

