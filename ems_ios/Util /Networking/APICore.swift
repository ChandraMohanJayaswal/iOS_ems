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

//protocol APIClient {
//    associatedtype EndPointType: APIEndPoint
//    func request(_ endpoint: EndPointType) async throws -> Data
//}

//final class DefaultAPIClient<EndpointType: APIEndPoint> {
//    func request(_ endpoint: EndpointType) async throws -> Data {
//        var url = endpoint.baseURL.appending(path: endpoint.path)
//        if endpoint.method == .get,
//            let parameters = endpoint.parameters
//        {
//
//            var components = URLComponents(
//                url: url,
//                resolvingAgainstBaseURL: false
//            )
//            components?.queryItems = parameters.map { key, value in
//                URLQueryItem(
//                    name: key,
//                    value: String(describing: value)
//                )
//            }
//            if let queryURL = components?.url {
//                url = queryURL
//            }
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = endpoint.method.rawValue
//
//        for (key, value) in endpoint.headers ?? [:] {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
//
//        if endpoint.method != .get,
//            let parameters = endpoint.parameters
//        {
//            request.httpBody = try JSONSerialization.data(
//                withJSONObject: parameters
//            )
//        }
//        print("===== REQUEST =====")
//        print("URL:", request.url?.absoluteString ?? "nil")
//        print("Method:", request.httpMethod ?? "nil")
//        print("Headers:", request.allHTTPHeaderFields ?? [:])
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            var extractedData: Data
//            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: data)
//                guard let json = jsonObject as? [String: Any],
//                      let dataObject = json["data"] else {
//                    throw APIError.invalidResponse
//                }
//                extractedData = try JSONSerialization.data(withJSONObject: dataObject)
//                let prettyData = try JSONSerialization.data(
//                    withJSONObject: jsonObject,
//                    options: .prettyPrinted
//                )
//                if let prettyString = String(
//                    data: prettyData,
//                    encoding: .utf8
//                ) {
//                    print("Pretty JSON:\n", prettyString)
//                }
//            } catch {
//                extractedData = data
//                print("Failed to parse JSON:", error)
//            }
//            if let body = request.httpBody,
//               let jsonString = String(data: body, encoding: .utf8)
//            {
//                print("Body:")
//                print(jsonString)
//            }
//            return extractedData
//
//        } catch {
//            print(error.localizedDescription)
//            throw APIError.invalidResponse
//        }
//    }
//}


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
}
