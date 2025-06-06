//
//  Serializer.swift
//  
//
//  Created by Evgenii Rtischev on 14/05/2023.
//

import Foundation

public protocol DeserializerProtocol {

    func deserialize<Response: Decodable>(_ type: Response.Type, from data: Data) -> Result<Response, Error>
}

public struct DeserializerDefault: DeserializerProtocol {
    private let decoder: JSONDecoder

    public init() {
        let decoder = JSONDecoder()
        self.init(decoder: decoder)
    }

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public func deserialize<T: Decodable>(_ type: T.Type, from data: Data) -> Result<T, Error> {
        do {
            let result = try decoder.decode(type, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
