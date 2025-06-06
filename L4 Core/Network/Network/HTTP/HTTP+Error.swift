//
//  HTTPError.swift
//  
//
//  Created by Evgenii Rtischev on 14/05/2023.
//

import Foundation

extension HTTP {

    public enum Error: LocalizedError {
        /// HTTP code is not 2xx or 3xx
        case http(code: Int, data: Data?)
        /// Network / transport error (URLSession error)
        case networkFailed(URLError)
        /// Network / transport error (cast to URLError didn't work)
        case unexpected
    }
}

extension HTTP.Error {

    public var errorDescription: String? {
        switch self {
        case let .networkFailed(error):
            return "[HTTP error] Network \(error.localizedDescription)"
        case .unexpected:
            return "[HTTP error] Unexpected"
        case .http(code: let code, data: let data):
            return "[HTTP error] HTTP code \(code), data: \(data?.utf8 ?? "Nil or not utf-8")"
        }
    }
}

fileprivate extension Data {

    var utf8: String? {
        return String(data: self, encoding: .utf8)
    }
}
