//
//  HTTPRequest.swift
//  
//
//  Created by Evgenii Rtischev on 11/05/2023.
//

import Foundation

public protocol HTTPRequest {
    var properties: HTTPRequestProperties { get }
}

public struct HTTPRequestProperties {
    /// HTTP request method
    public let method: HTTP.Method

    /// Path for URL
    public let path: String

    /// Headers, that can be added for particular request. Empty by default.
    public let additionalHeaders: [String: String]

    /// Query paramters, that added to the request URL.
    public let queryParams: [String: String]

    /// The data sent as the message body of a request, such as for an HTTP POST request.
    public let body: Data?

    public init(
        method: HTTP.Method,
        path: String,
        additionalHeaders: [String: String] = [:],
        queryParams: [String: String] = [:],
        body: Data? = nil) {
        self.method = method
        self.path = path
        self.additionalHeaders = additionalHeaders
        self.queryParams = queryParams
        self.body = body
    }
}
