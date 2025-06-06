//
//  AppStartRule.swift
//  Applications
//
//  Created by Evgenii Rtischev on 05/06/2025.
//

import LoggerCore
import StorageL3
import CatFactAPIL3

struct AppStartRule {

	private let storage = Storage()
	private let api = CatFactAPIFactory.make()

	func perform() {
		Logger.configure(.default)
		Logger.log(level: .info, message: "Test")

		print(storage.firstLaunch)

		storage.firstLaunch = false

		api.getFact { result in
			if case let .success(response) = result {
				Logger.log(level: .info, message: "I got a new cat fact! \(response.fact)")
			}
		}
	}
}
