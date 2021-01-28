//
//  NetworkFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol NetworkRequestFactoryProtocol {
    ///  Creates a get request.
    ///
    /// - Parameter url: The address of the request.
    /// - Parameter parameters: Parameters for the request.
    /// - Parameter resultHandler: The result handler of the request..
    /// - Returns: Returns a get request.
    func get<T: ParametersProtocol>(
        url: URL,
        parameters: T,
        resultHandler: NetworkResultHandler?
    ) throws -> RequestProtocol
}

extension NetworkRequestFactoryProtocol {
    func get(url: URL, resultHandler: NetworkResultHandler?) throws -> RequestProtocol {
        try get(url: url, parameters: EmptyParameters(), resultHandler: resultHandler)
    }
}

struct NetworkRequestFactory: NetworkRequestFactoryProtocol {

    // MARK: - Public Properties

    func get<T: ParametersProtocol>(
        url: URL,
        parameters: T,
        resultHandler: NetworkResultHandler? = nil
    ) throws -> RequestProtocol {
        try GetRequest(url: url, parameters: parameters, resultHandler: resultHandler)
    }
}
