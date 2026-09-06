//
//  APIMetrics.swift
//  ems_ios
//
//  Created by MacMini on 06/09/2026.
//
import Foundation
protocol APIMetrics {
    func getMetrics(success: @escaping (Metrics) -> Void, failure: @escaping (Error) -> Void) async
}
extension APIMetrics {
    func getMetrics(success: @escaping (Metrics) -> Void, failure: @escaping (Error) -> Void) async {
        let apiClient = DefaultAPIClient<EndPointHome>()
        do {
            let data = try await apiClient.request(EndPointHome.getMetrics)
            let decoded = try JSONDecoder().decode(
                MetricsResponse.self,
                from: data
            )
            if let metrics = decoded.metrics {
                success(metrics)
            } else {
                failure(APIError.decodeError)
            }
        } catch {
            print("Error in fetching metrics", error)
            failure(error)
        }
    }
}
