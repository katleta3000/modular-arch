
import Foundation

public extension Logger {

	enum LogLevel: CaseIterable {
		/// Critical means the app or code cannot continue functioning correctly.
		/// There is usually no fallback logic to handle this case.
		/// Example: database initialization error or migration failure.
		case critical

		/// Error indicates a failure that breaks the app, but is a predictable scenario.
		/// Example: deserialization error of types received from the backend.
		case error

		/// Warning represents a situation that may cause problems in the future.
		/// A zero-warning tolerance approach is always preferable.
		case warning

		/// Informational messages for tracking user behavior or app events.
		/// Example: received attribution or push token, opened a screen.
		case info

		/// Used strictly for debugging purposes.
		case debug

		/// Detailed logs for tracing integration paths (e.g., database or network).
		/// Example: HTTP request trace.
		case trace
	}
}
