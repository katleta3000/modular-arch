//
//  API.swift
//  
//
//  Created by Evgenii Rtischev on 11/05/2023.
//

import Foundation

public protocol API {

    var httpClient: HTTPClientProtocol { get }
    var urlRequestFactory: URLRequestFactoryProtocol { get }

    /// Default deserializer for the success responses
    var responseDeserializer: DeserializerProtocol { get }

    /// Deserializer for the failure responses
    var responseErrorDeserializer: DeserializerProtocol { get }

	/// The factory creating HTTP headers for each HTTPRequest per API, overriding URLSessionConfiguration headers
	var headersFactory: API.HeadersFactoryProtocol? { get }

    init(httpClient: HTTPClientProtocol, baseURL: URL)
}

public typealias APICompletionFull<Response: Decodable, ErrorResponse: Decodable> = (
    (Result<Response, APIError<ErrorResponse>>) -> Void
)

public typealias APICompletionDictionary = (Result<[String: Any], APIError<Empty>>) -> Void

public typealias APICompletionShort<Response: Decodable> = (Result<Response, APIError<Empty>>) -> Void

public typealias APICompletionEmpty = (Result<Void, APIError<Empty>>) -> Void

public struct Empty: Decodable { }
