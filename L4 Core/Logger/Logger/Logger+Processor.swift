
import Foundation
//import FirebaseCrashlytics

public extension Logger {

	protocol Processor {
		func processLog(
			level: LogLevel,
			message: String,
			details: [String: AnyHashable]?,
			calledFile: String,
			calledFunction: String
		)
	}

	struct ConsolePrintProcessor: Processor {
		public func processLog(
			level: LogLevel,
			message: String,
			details: [String: AnyHashable]?,
			calledFile: String,
			calledFunction: String
		) {
			var detailString = ""
			if let details {
				for (key, value) in details.sorted(by: { $0.key < $1.key }) {
					detailString += " \(key)=\(value)"
				}
			}
			let file = calledFile.replacingOccurrences(of: ".swift", with: "")
			let function = shortFuncName(calledFunction)
			print("[Logger:\(level) \(file):\(function)] \(message)\(detailString)")
		}
	}

//	struct FirebaseNonFatalsProcessor: Processor {
//
//		public func processLog(
//			level: LogLevel,
//			message: String,
//			details: [String: AnyHashable]?,
//			calledFile: String,
//			calledFunction: String
//		) {
//			var userInfo: [String: AnyHashable] = [
//				"message": message,
//				"level": String(describing: level)
//			]
//			if let details {
//				for (key, value) in details.sorted(by: { $0.key < $1.key }) {
//					userInfo[key] = value
//				}
//			}
//			let file = calledFile.replacingOccurrences(of: ".swift", with: "")
//			let function = shortFuncName(calledFunction)
//			let domain = "\(file):\(function)"
//			let code = 0
//
//			let error = NSError(domain: domain, code: code, userInfo: userInfo)
//			Crashlytics.crashlytics().record(error: error, userInfo: userInfo)
//		}
//	}
}

private extension Logger {

	static func shortFuncName(_ string: String) -> String {
		if let index = string.firstIndex(of: "(") {
			return String(string[..<index])
		}
		return string
	}
}
