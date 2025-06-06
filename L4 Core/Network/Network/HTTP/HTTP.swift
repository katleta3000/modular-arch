//
//  File.swift
//  
//
//  Created by Evgenii Rtischev on 09/05/2023.
//

import Foundation

public enum HTTP {

    public enum Header {
        public static let contentType = "Content-Type"
        public static let acceptType = "Accept"
        public static let acceptLanguage = "Accept-Language"
		public static let userAgent = "User-Agent"
    }

    public enum ContentType {
        public static let json = "application/json"
        public static let plainText = "text/plain"
    }

    public enum Method: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case head = "HEAD"
        case delete = "DELETE"
    }

    public typealias RequestCompletion = (Result<Response, Error>) -> Void

    public struct Response {
        let data: Data?
        let httpStatusCode: Int
    }
}
