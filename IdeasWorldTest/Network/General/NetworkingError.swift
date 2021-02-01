//
//  NetworkingError.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

enum NetworkingError: LocalizedError, Equatable {
    static func == (left: NetworkingError, right: NetworkingError) -> Bool {
        switch (left, right) {
        case let (.httpError(leftStatusCode), .httpError(rightStatusCode)):
            return leftStatusCode == rightStatusCode
        case (.emptyResponse, .emptyResponse):
            return true
        default:
            return false
        }
    }
    
    case error(Error)
    case emptyResponse
    case httpError(statusCode: HTTPStatusCode)
    
    var errorDescription: String? {
        switch self {
        case .error:
            return "Something wrong."
        case .emptyResponse:
        return "Empty response."
        case let .httpError(statusCode):
            return "Error \(statusCode)."
        }
    }
}
