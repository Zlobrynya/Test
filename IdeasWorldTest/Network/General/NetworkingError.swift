//
//  NetworkingError.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

enum NetworkingError {
    case error(Error)
    case emptyResponse
    case httpError(statusCode: HTTPStatusCode)
}
