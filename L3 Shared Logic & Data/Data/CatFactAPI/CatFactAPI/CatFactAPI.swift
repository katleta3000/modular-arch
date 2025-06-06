//
//  CatFactAPI.swift
//  CatFactAPI
//
//  Created by Evgenii Rtischev on 06/06/2025.
//

import Foundation
import NetworkCore

public protocol CatFactAPIProtocol {

	func getFact(completion: @escaping APICompletionShort<CatFactAPI.FactResponse>)
}

public final class CatFactAPI: API, CatFactAPIProtocol {

	public var urlRequestFactory: URLRequestFactoryProtocol
	
	public let httpClient: HTTPClientProtocol
	public let responseDeserializer: DeserializerProtocol
	public let responseErrorDeserializer: DeserializerProtocol
	public let headersFactory: API.HeadersFactoryProtocol? = nil

	public init(httpClient: HTTPClientProtocol, baseURL: URL) {
		self.httpClient = httpClient

		urlRequestFactory = URLRequestFactoryDefault(baseURL: baseURL)

		let deserializer = DeserializerDefault()
		responseDeserializer = deserializer
		responseErrorDeserializer = deserializer
	}
}
