//
//  APIGetLineManagers.swift
//  ems_ios
//
//  Created by MacMini on 23/08/2026.
//
import Foundation
protocol APIGetLineManagers {
    func getLineManagers(completion: @escaping ([LineManager]) -> Void) async
}
extension APIGetLineManagers {
    func getLineManagers(completion: @escaping ([LineManager]) -> Void) async {
        let apiClient = DefaultAPIClient<EndPointUser>()
        do {
            let data = try await apiClient.request(EndPointUser.getLineManager)
            let decoded = try JSONDecoder().decode(LineManagerResponse.self, from: data)
            completion(decoded.lineManagerList ?? [])
        } catch {
            print("Server Error", error.localizedDescription)
        }
    }
}
