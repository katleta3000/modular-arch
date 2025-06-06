//
//  HTTPClient+Logging.swift
//  
//
//  Created by Evgenii Rtischev on 27/05/2023.
//

import Foundation
import LoggerCore

public final class HTTPClientLoggingDecorator: HTTPClientProtocol {

    public func performRequest(_ request: URLRequest, completion: @escaping HTTP.RequestCompletion) -> HTTPClientTask {
        let method = request.httpMethod ?? "nil method"
        let url = request.url?.absoluteString ?? "nil url"
        let body: String
        if let httpBody = request.httpBody {
            body = String(data: httpBody, encoding: .utf8) ?? "not uft8"
        } else {
            body = "empty body"
        }
        let task = decoratedClient.performRequest(request) { result in
            switch result {
            case let .success(response):
                let data: String
                if let responseData = response.data {
                    data = String(data: responseData, encoding: .utf8) ?? "not uft8"
                } else {
                    data = "empty data"
                }
                Logger.log(
                    level: .trace,
                    message: "Response \(method) \(url) statusCode \(response.httpStatusCode) \(data)"
                )
            case let.failure(error):
                Logger.log(
					level: .trace,
					message: "Request failed \(method) \(url)",
					details: ["error": error.localizedDescription]
				)
            }
            completion(result)
        }
        let headers = task.headers
        Logger.log(
            level: .trace,
            message: "Request \(method) \(url) headers: \(headers) body: \(body)"
        )
        return task
    }

    private let decoratedClient: HTTPClientProtocol

    public init(_ client: HTTPClientProtocol) {
        decoratedClient = client
    }
}
