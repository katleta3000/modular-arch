
import Foundation

public extension Logger {

	static internal var configuration = Configuration.`notConfigured`

	static func configure(_ configuration: Configuration) {
		self.configuration = configuration
	}
	
	struct Configuration {

		public init(enabledLogLevels: [LogLevel], processors: [Processor]) {
			self.enabledLogLevels = enabledLogLevels
			self.processors = processors
		}

		public static var `default`: Configuration {
			.init(enabledLogLevels: LogLevel.allCases, processors: [ConsolePrintProcessor()])
		}

		public static var `errorsAndWarnings`: Configuration {
			.init(enabledLogLevels: [.error, .critical, .warning], processors: [ConsolePrintProcessor()])
		}

		public static var `production`: Configuration {
			.init(enabledLogLevels: [.error, .critical, .warning], processors: [])
		}

		let enabledLogLevels: [LogLevel]?
		let processors: [Processor]

		init(enabledLogLevels: [LogLevel]?, processors: [Processor]) {
			self.enabledLogLevels = enabledLogLevels
			self.processors = processors
		}
		
		static var `notConfigured`: Configuration {
			.init(enabledLogLevels: nil, processors: [])
		}
	}
}
