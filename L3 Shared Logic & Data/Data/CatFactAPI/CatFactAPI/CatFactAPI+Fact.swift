//
//  CatFactAPI+Facts.swift
//  CatFactAPI
//
//  Created by Evgenii Rtischev on 06/06/2025.
//

import Foundation
import NetworkCore

extension CatFactAPI {

	public struct GetFactRequest: HTTPRequest {

		public var properties: HTTPRequestProperties {
			.init(
				method: .get,
				path: "fact"
			)
		}
	}

	public struct FactResponse: Codable {
		public let fact: String
		public let length: Int
	}

	public func getFact(completion: @escaping APICompletionShort<CatFactAPI.FactResponse>) {
		perform(CatFactAPI.GetFactRequest(), completion: completion)
	}

}
