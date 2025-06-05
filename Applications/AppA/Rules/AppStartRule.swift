//
//  AppStartRule.swift
//  Applications
//
//  Created by Evgenii Rtischev on 05/06/2025.
//

import LoggerCore
import StorageL3

struct AppStartRule {

	private let storage = Storage()

	func perform() {
		Logger.configure(.default)
		Logger.log(level: .info, message: "Test")

		print(storage.firstLaunch)

		storage.firstLaunch = false
	}
}
