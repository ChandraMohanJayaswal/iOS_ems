//
//  APILogin.swift
//  iOS_EMS
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
            if let token = decoded.token, let user = decoded.user {
                do {
                    try EMSManager.shared.login(user: user,token: token)
                } catch {
                    print("Error: \(error.localizedDescription)")
                        if let recoverySuggestion = (error as? LocalizedError)?.recoverySuggestion {
                            print("Suggestion: \(recoverySuggestion)")
                        }
                }
            }
            success()
        } catch {
            print("Failure in login")
            failure(error.localizedDescription)
        }
    }
}
