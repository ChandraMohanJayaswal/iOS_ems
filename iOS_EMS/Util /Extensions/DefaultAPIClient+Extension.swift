//
//  DefaultAPIClient+Extension.swift
//  iOS_EMS
//
//  Created by MacMini on 06/09/2026.
//
import Foundation
// MARK: - Request Building
extension DefaultAPIClient {
    func buildRequest(for endpoint: EndpointType) throws -> URLRequest {
        let url = buildURL(for: endpoint)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        addHeaders(to: &request, from: endpoint)

        if endpoint.method != .get {
            request.httpBody = try makeBody(from: endpoint.parameters)
        }
        return request
    }

    private func buildURL(for endpoint: EndpointType) -> URL {
        let url = endpoint.baseURL.appending(path: endpoint.path)

        guard endpoint.method == .get,
              let parameters = endpoint.parameters,
              !parameters.isEmpty
        else {
            return url
        }

        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = parameters.map { key, value in
            URLQueryItem(
                name: key,
                value: String(describing: value)
            )
        }

        return components?.url ?? url
    }

    private func addHeaders(
        to request: inout URLRequest,
        from endpoint: EndpointType
    ) {
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        request.setValue(
            "*/*",
            forHTTPHeaderField: "Accept"
        )
        if let token = EMSManager.shared.token {
            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }
        for (key, value) in endpoint.headers ?? [:] {
            request.setValue(
                value,
                forHTTPHeaderField: key
            )
        }
    }

    private func makeBody(
        from parameters: [String: Any]?
    ) throws -> Data? {
        guard let parameters else {
            return nil
        }

        return try JSONSerialization.data(
            withJSONObject: parameters
        )
    }
}
extension DefaultAPIClient {
    func extractData(from data: Data) throws -> Data {
        let json = try JSONSerialization.jsonObject(with: data)
        guard let response = json as? [String: Any],
              let responseData = response["data"]
        else {
            throw APIError.invalidResponse
        }
        return try JSONSerialization.data(
            withJSONObject: responseData
        )
    }
}
// MARK: - Logging
extension DefaultAPIClient {
    func logRequest(_ request: URLRequest) {
        print("""
        ===== REQUEST =====
        URL: \(request.url?.absoluteString ?? "nil")
        Method: \(request.httpMethod ?? "nil")
        Headers: \(request.allHTTPHeaderFields ?? [:])
        """)

        guard let body = request.httpBody,
              let bodyString = String(data: body, encoding: .utf8)
        else {
            return
        }

        print("Body:")
        print(bodyString)
    }

    func logResponse(_ data: Data) {
        guard let jsonObject = try? JSONSerialization.jsonObject(
            with: data
        ),
        let prettyData = try? JSONSerialization.data(
            withJSONObject: jsonObject,
            options: .prettyPrinted
        ),
        let prettyString = String(
            data: prettyData,
            encoding: .utf8
        )
        else {
            print("Response: \(String(data: data, encoding: .utf8) ?? "Unable to decode response")")
            return
        }

        print("""
        ===== RESPONSE =====
        \(prettyString)
        """)
    }
}
