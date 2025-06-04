///
public struct Logger {

	public static func log(
		level: LogLevel,
		message: String,
		details: [String: AnyHashable]? = nil,
		calledFile: String = #fileID,
		calledFunction: String = #function
	) {
        guard let levels = configuration.enabledLogLevels else {
            assert(false, "Logger should be configured for usage")
			return
		}
        if levels.contains(level) {
			configuration.processors.forEach {
				$0.processLog(
					level: level,
					message: message,
					details: details,
					calledFile: calledFile,
					calledFunction: calledFunction
				)
			}
        }
    }
}
