//
//  URLRequestFactory.swift
//  
//
//  Created by Evgenii Rtischev on 12/05/2023.
//

import Foundation

public protocol URLRequestFactoryProtocol {
    /// Convert HTTPRequest to URLRequest for performing by URLSession
    /// - Parameters:
    ///   - request: Request params
    ///   - headers: Additional common and possibly dynamic headers that might be passed along with the request headers
    /// - Returns: URLRequest
    func make(request: HTTPRequest, headers: [String: String]) -> URLRequest
}

public struct URLRequestFactoryDefault: URLRequestFactoryProtocol {

    public let baseURL: URL

    public func make(request: HTTPRequest, headers: [String: String]) -> URLRequest {
        let properties = request.properties

        var finalURL = baseURL.appendingPathComponent(properties.path)
        if var urlComponents = URLComponents(url: baseURL.appendingPathComponent(properties.path), resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            properties.queryParams.forEach {
                queryItems.append(URLQueryItem(name: $0.key, value: $0.value))
            }
            urlComponents.queryItems = queryItems
            if let url = urlComponents.url {
                finalURL = url
            }
        }
        var urlRequest = URLRequest(url: finalURL)
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        properties.additionalHeaders.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        urlRequest.httpMethod = properties.method.rawValue
        properties.body.map { urlRequest.httpBody = $0 }
        return urlRequest
    }

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }
}
