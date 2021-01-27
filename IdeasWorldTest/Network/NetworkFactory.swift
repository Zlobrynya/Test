//
//  NetworkFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol NetworkFactoryProtocol {
    func get<T: ParametersProtocol>(url: URL, parameters: T, resultHandler: NetworkResultHandler?) throws -> RequestProtocol
}

struct NetworkFactory: NetworkFactoryProtocol {

    // MARK: - Public Properties

    func get<T: ParametersProtocol>(
        url: URL,
        parameters: T,
        resultHandler: NetworkResultHandler? = nil
    ) throws -> RequestProtocol {
       try GetRequest(url: url, parameters: parameters, resultHandler: resultHandler)
    }
}
