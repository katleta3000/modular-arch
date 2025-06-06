//
//  API+Perform.swift
//  
//  Created by Evgenii Rtischev on 14/05/2023.
//

import Foundation

public extension API {

    func perform(_ request: HTTPRequest, completion: @escaping APICompletionEmpty) {
        let performCompletion: APICompletionFull<Empty, Empty> = { result in
            switch result {
            case .success:
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        performRequest(
            request,
            responseSerializer: responseDeserializer,
            responseErrorSerializer: responseErrorDeserializer,
            completion: performCompletion
        )
    }

    func perform<Response: Decodable>(
        _ request: HTTPRequest,
        completion: @escaping APICompletionShort<Response>
    ) {
        performRequest(
            request,
            responseSerializer: responseDeserializer,
            responseErrorSerializer: nil,
            completion: completion
        )
    }

    func perform<Response: Decodable, ResponseError: Decodable>(
        _ request: HTTPRequest,
        completion: @escaping APICompletionFull<Response, ResponseError>
    ) {
        performRequest(
            request,
            responseSerializer: responseDeserializer,
            responseErrorSerializer: responseErrorDeserializer,
            completion: completion
        )
    }

    func perform(_ request: HTTPRequest, completion: @escaping APICompletionDictionary) {
        httpClient.performRequest(urlRequest(for: request)) { result in
            switch result {
            case let .success(response):
                guard let data = response.data, !data.isEmpty else {
                    completion(.failure(.serializationEmptyData))
                    return
                }
                do {
                    let result = try JSONSerialization.jsonObject(
                        with: data,
                        options: .allowFragments
                    ) as? [String: Any] ?? [:]
                    completion(.success(result))
                } catch let error {
                    completion(.failure(.serializationFailed(error)))
                }
            case let .failure(error):
                switch error {
                case let .networkFailed(networkError):
                    completion(.failure(.networkFailed(networkError)))
                case .unexpected:
                    completion(.failure(.unexpected))
                case .http(let code, let data):
                    completion(.failure(.http(code: code, response: nil, rawData: data)))
                }
            }
        }
    }
}

private extension API {

    func urlRequest(for request: HTTPRequest) -> URLRequest {
        return urlRequestFactory.make(request: request, headers: headersFactory?.makeHeaders() ?? [:])
    }

    // swiftlint:disable:next cyclomatic_complexity
    func performRequest<Response: Decodable, ResponseError: Decodable>(
        _ request: HTTPRequest,
        responseSerializer: DeserializerProtocol,
        responseErrorSerializer: DeserializerProtocol?,
        completion: @escaping (Result<Response, APIError<ResponseError>>) -> Void
    ) {
        httpClient.performRequest(urlRequest(for: request)) { result in
            switch result {
            case let .success(response):
                guard let data = response.data, !data.isEmpty else {
                    completion(.failure(.serializationEmptyData))
                    return
                }
                switch responseSerializer.deserialize(Response.self, from: data) {
                case let .success(serializedResponse):
                    completion(.success(serializedResponse))
                case let .failure(serializationError):
                    completion(.failure(.serializationFailed(serializationError)))
                }
            case let .failure(error):
                switch error {
                case let .networkFailed(networkError):
                    completion(.failure(.networkFailed(networkError)))
                case .unexpected:
                    completion(.failure(.unexpected))
                case .http(let code, let data):
                    if let data, let responseErrorSerializer {
                        switch responseErrorSerializer.deserialize(ResponseError.self, from: data) {
                        case let .success(serializedErrorReponse):
                            completion(.failure(.http(code: code, response: serializedErrorReponse, rawData: data)))
                        case .failure:
                            completion(.failure(.http(code: code, response: nil, rawData: data)))
                        }
                    } else {
                        completion(.failure(.http(code: code, response: nil, rawData: data)))
                    }
                }
            }
        }
    }
}
