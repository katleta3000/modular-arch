//
//  API+Error.swift
//  
//
//  Created by Evgenii Rtischev on 14/05/2023.
//

import Foundation

public enum APIError<ErrorResponse: Decodable>: Error {

    /// Tried to serialize success response, but no http data received
    case serializationEmptyData

    /// Tried to serialize success response, but received error
    case serializationFailed(Error)

    /// Received HTTP error with possible response body
    /// see HTTP.Error
    /// Possible serialization errors lead to nil in `response`
    case http(code: Int, response: ErrorResponse?, rawData: Data?)

    /// Network / transport error (URLSession error)
    /// see HTTP.Error
    case networkFailed(URLError)

    /// Network / transport error (cast to URLError didn't work)
    /// see HTTP.Error
    case unexpected

    public var isNetwork: Bool {
        switch self {
        case .unexpected, .networkFailed: return true
        default: return false
        }
    }

    public var isCancelled: Bool {
        guard case let .networkFailed(error) = self else { return false }
        return error.code == .cancelled
    }
}

extension APIError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case let .networkFailed(error):
            return "[API error] Network code \(error.code), description: \(error.localizedDescription)"
        case .unexpected:
            return "[API error] Network unexpected"
        case .serializationEmptyData:
            return "[API error] Serialization no data"
        case let .serializationFailed(error):
            return "[API error] Serialization: \(error.localizedDescription)"
        case let .http(code, response, rawData):
            if let response {
                return "[API error] HTTP code \(code), response: \(String(describing: response))"
            } else if let rawData {
                return "[API error] HTTP code \(code), rawData: \(String(data: rawData, encoding: .utf8) ?? "")"
            } else {
                return "[API error] HTTP code \(code)"
            }
        }
    }
}
