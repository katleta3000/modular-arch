//
//  API+Headers.swift
//
//
//  Created by Evgenii Rtischev on 25/08/2024.
//

import Foundation

public extension API {
	typealias HeadersFactoryProtocol = APIHeadersFactoryProtocol
}
public protocol APIHeadersFactoryProtocol {
	func makeHeaders() -> [String: String]
}
