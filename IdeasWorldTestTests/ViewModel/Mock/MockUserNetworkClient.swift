//
//  MockUserNetworkClient.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
@testable import IdeasWorldTest

class MockUserNetworkClient: UserNetworkClientProtocol {

    // MARK: - Public Properties

    var resultHandler: UserNetworkClientResultHandler?
    var username: String?

    // MARK: - Public Functions

    func user(forUsername username: String) {
        self.username = username
    }

    // MARK: - NetworkResultHandler Conformance

    func requestFailedWithResult(_ result: Data) {}

    func requestFailedWithError(_ error: Error) {}
}
