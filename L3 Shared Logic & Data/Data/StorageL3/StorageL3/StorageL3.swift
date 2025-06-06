//
//  StorageL3.swift
//  StorageL3
//
//  Created by Evgenii Rtischev on 05/06/2025.
//

import Foundation
import StorageCore

private let defaultsContainer = UserDefaults.standard

public protocol StorageKeysProtocol {
	var firstLaunch: Bool { get set }
}

public final class Storage: StorageKeysProtocol {

	@StoredSetting(key: Storage.Keys.firstLaunch, container: defaultsContainer, defaultValue: true)
	public var firstLaunch: Bool

	public init() { }
}

public extension Storage {
	enum Keys: String, StorageKey {
		public var stringValue: String {
			"Setting.\(self.rawValue)"
		}
		case firstLaunch
	}
}
