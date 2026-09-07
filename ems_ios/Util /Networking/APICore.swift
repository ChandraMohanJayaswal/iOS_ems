//
//  Core.swift
//  ems_ios
//
//  Created by MacMini on 07/01/2026.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error {
    case invalidResponse
    case serverUnreachable
    case decodeError
}

protocol APIEndPoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

final class DefaultAPIClient<EndpointType: APIEndPoint> {
    func request(_ endpoint: EndpointType) async throws -> Data {
        let request = try buildRequest(for: endpoint)
        logRequest(request)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            logResponse(data)
            return try extractData(from: data)
        } catch let error as APIError {
            throw error
        } catch {
            print("Request failed:", error.localizedDescription)
            throw APIError.invalidResponse
        }
    }

    deinit {
        print("DefaultAPIClient deinitialized")
    }
}
