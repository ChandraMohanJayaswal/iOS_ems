//
//  APILogin.swift
//  ems_ios
//
//  Created by MacMini on 30/01/2026.
//
import Foundation
import KeychainSwift

protocol APILogin {
    func login(
        email: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping (String) -> Void
    ) async
}
extension APILogin {
    func login(
        email: String,
        password: String,
        success: @escaping () -> Void,
        failure: @escaping (String) -> Void
    ) async {
        let loginEnum = EndPointLogin.login(username: email, password: password)
        let apiClient = DefaultAPIClient<EndPointLogin>()
        do {

            let data = try await apiClient.request(loginEnum)
            let decoded = try JSONDecoder().decode(
                Login.self,
                from: data
            )
            if let token = decoded.token {
                UserDefaultsManager.shared.login(
                    id: decoded.user?.id ?? 0,
                    firstName: decoded.user?.firstName ?? "",
                    lastName: decoded.user?.lastName ?? "",
                    gender: decoded.user?.gender ?? "",
                    emailAddress: decoded.user?.emailAddress ?? "",
                    mobileNumber: decoded.user?.mobileNumber ?? "",
                    title: decoded.user?.role?.title ?? "",
                    token: token
                )
            }
            success()
        } catch {
            print("Failure in login")
            failure(error.localizedDescription)
        }
    }
}
