//
//  HTTPClient.swift
//  
//
//  Created by Evgenii Rtischev on 09/05/2023.
//

import Foundation

public protocol HTTPClientProtocol {

    @discardableResult
    func performRequest(
        _ request: URLRequest,
        completion: @escaping HTTP.RequestCompletion
    ) -> HTTPClientTask
}

public protocol HTTPClientTask {
    var headers: [String: String] { get }
}

extension URLSessionDataTask: HTTPClientTask {

    public var headers: [String: String] {
        self.currentRequest?.allHTTPHeaderFields ?? [:]
    }
}

public final class HTTPClient: HTTPClientProtocol {

    private let urlSession: URLSession

    public init(
        configuration: URLSessionConfiguration) {
        urlSession = URLSession(configuration: configuration)
    }

    public func performRequest(
        _ request: URLRequest,
        completion: @escaping HTTP.RequestCompletion
    ) -> HTTPClientTask {
        let task = urlSession.dataTask(with: request) { data, response, error in
            if let error {
                // All errors produced by data tasks are `URLError`. See original documentation.
                // "Errors will be returned in the NSURLErrorDomain, see <Foundation/NSURLError.h>" @ Apple.
                if let error = error as? URLError {
                    completion(.failure(.networkFailed(error)))
                } else {
                    completion(.failure(.unexpected))
                }
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if (200..<300).contains(httpResponse.statusCode) {
                    let response = HTTP.Response(data: data, httpStatusCode: httpResponse.statusCode)
                    completion(.success(response))
                } else {
                    completion(.failure(.http(code: httpResponse.statusCode, data: data)))
                }
            } else {
                completion(.failure(.unexpected))
            }
        }
        task.resume()
        return task
    }
}
