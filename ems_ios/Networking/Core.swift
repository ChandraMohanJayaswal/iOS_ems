//
//  Core.swift
//  ems_ios
//
//  Created by MacMini on 07/01/2026.
//
import Foundation

enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIError: Error{
    case invalidResponse
    case invalidData
}

protocol APIEndPoint{
    var baseURL :  URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

protocol APIClient{
    associatedtype EndPointType: APIEndPoint
    func request(_ endpoint: EndPointType) async throws -> Data
}

final class DefaultAPIClient<EndpointType: APIEndPoint>{
    func request(_ endpoint: EndpointType) async throws -> Data{
        let urlComponents = endpoint.baseURL.appending(path: endpoint.path)
        var request = URLRequest(url: urlComponents)
        request.httpMethod = endpoint.method.rawValue
        for (key, value) in endpoint.headers ?? [:]{
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let body = endpoint.parameters{
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                throw APIError.invalidResponse
            }
            return data
        }
        catch {
            print("I am here")
            print(error.localizedDescription)
        }
        throw APIError.invalidResponse
    }
}
// Upto here is the generalized one

