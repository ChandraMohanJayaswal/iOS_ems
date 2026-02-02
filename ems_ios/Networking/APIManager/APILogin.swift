//
//  APILogin.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
import KeychainSwift
protocol APILogin{
    func login(email: String, password: String) async throws->Void
}
extension APILogin{
    func login(email: String, password: String) async throws -> Void{
        let loginEnum = EndPointLogin.login(username: email, password:password)
        let apiClient = DefaultAPIClient<EndPointLogin>()
        do{
            
            let data = try await apiClient.request(loginEnum)
            let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
            UserDefaultsManager.shared.login(firstName: decoded.data?.user?.firstName ?? "", lastName: decoded.data?.user?.lastName ?? "", gender: decoded.data?.user?.gender ?? "", emailAddress: decoded.data?.user?.emailAddress ?? "", mobileNumber: decoded.data?.user?.mobileNumber ?? "", title: decoded.data?.user?.role?.title ?? "", token: decoded.data?.token ?? "")
        }
        catch{
            print("Server Error")
            throw error
        }
    }
}
