//
//  MockUserNetworkClientResultHandler.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
@testable import IdeasWorldTest

class MockUserNetworkClientResultHandler: UserNetworkClientResultHandler {
    
    // MARK: - Public Properties
    
    var user: UserProtocol?
    var error: Error?
    
    // MARK: - UserNetworkClientResultHandler Conformance
    
    func userRequestDidSucceed(_ user: UserProtocol) {
        self.user = user
    }
    
    func userRequestDidFailed(_ error: Error) {
        self.error = error
    }
    
}
