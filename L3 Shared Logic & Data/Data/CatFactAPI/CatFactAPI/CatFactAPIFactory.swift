//
//  CatFactAPIFactory.swift
//  CatFactAPI
//
//  Created by Evgenii Rtischev on 06/06/2025.
//

import Foundation
import NetworkCore

public enum CatFactAPIFactory {

	public static func make() -> CatFactAPIProtocol {
		CatFactAPI(
			httpClient: makeHTTPClient(),
			baseURL: URL(string: "https://catfact.ninja/")!
		)
	}

	private static func makeHTTPClient() -> HTTPClientProtocol {
		let configuration = URLSessionConfiguration.default
		configuration.httpAdditionalHeaders = [HTTP.Header.contentType: HTTP.ContentType.plainText]
		return HTTPClientLoggingDecorator(HTTPClient(configuration: configuration))
	}
}
