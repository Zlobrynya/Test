//
//  MockNetworkRequestFactoryProtocol.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
@testable import IdeasWorldTest

class MockNetworkRequestFactory: NetworkRequestFactoryProtocol {

    // MARK: - Public Properties

    var request: MockRequest?
    var url: URL?
    var shouldThrowError = false

    // MARK: - Public Functions

    func get<T: ParametersProtocol>(
        url: URL,
        parameters: T,
        resultHandler: NetworkResultHandler?
    ) throws -> RequestProtocol {
        self.url = url
        request = try MockRequest(shouldThrowError: shouldThrowError)
        // swiftlint:disable:next force_unwrapping
        return request!
    }
}
