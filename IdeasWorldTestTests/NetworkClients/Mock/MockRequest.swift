//
//  MockRequest.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
@testable import IdeasWorldTest

class MockRequest: RequestProtocol {
    
    // MARK: - Public Properties
    
    var didCallSend = false
    var didCallCancel = false
    
    // MARK: - Lifecycle
    
    init(shouldThrowError: Bool) throws {
        guard shouldThrowError else { return }
        throw NetworkingError.emptyResponse
    }
    
    // MARK: - Public Functions
    
    func send() {
        didCallSend = true
    }
    
    func cancel() {
        didCallCancel = true
    }
    
}
