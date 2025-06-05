//
//  Storage.swift
//  Storage
//
//  Created by Evgenii Rtischev on 05/06/2025.
//

import Foundation
import LoggerCore

public protocol ContainerProtocol {
	func object(forKey defaultName: String) -> Any?
	func set(_ value: Any?, forKey defaultName: String)
	func removeObject(forKey defaultName: String)
}

extension UserDefaults: ContainerProtocol { }

public protocol StorageKey {
	var stringValue: String { get }
}

@propertyWrapper
public struct StoredSetting<Value> {
	public let key: StorageKey
	public let container: ContainerProtocol
	public let defaultValue: Value

	public var wrappedValue: Value {
		get {
			let value = container.object(forKey: key.stringValue) as? Value ?? defaultValue
			return value
		}
		set {
			container.set(newValue, forKey: key.stringValue)
			Logger.log(level: .info, message: "Write to storage", details: ["key":  key.stringValue, "value": "\(newValue)"])
		}
	}

	public init(key: StorageKey, container: ContainerProtocol, defaultValue: Value) {
		self.key = key
		self.container = container
		self.defaultValue = defaultValue
	}
}

@propertyWrapper
public struct StoredSettingNullable<Value> {
	public let key: StorageKey
	public let container: ContainerProtocol
	public let defaultValue: Value?

	public var wrappedValue: Value? {
		get {
			let value = container.object(forKey: key.stringValue) as? Value ?? defaultValue
			return value
		}
		set {
			if newValue == nil {
				container.removeObject(forKey: key.stringValue)
				Logger.log(level: .info, message: "Remove value from storage", details: ["key": key.stringValue])
			} else {
				container.set(newValue, forKey: key.stringValue)
				Logger.log(level: .info, message: "Write to storage", details: ["key":  key.stringValue, "value": String(describing: newValue)])
			}
		}
	}

	public init(key: StorageKey, container: ContainerProtocol, defaultValue: Value?) {
		self.key = key
		self.container = container
		self.defaultValue = defaultValue
	}
}
