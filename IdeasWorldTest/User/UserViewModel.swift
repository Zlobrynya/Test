//
//  UserViewModel.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

class UserViewModel: UserNetworkClientResultHandler {

    // MARK: - External Dependencies
    
    private let networkClient: UserNetworkClientProtocol

    // MARK: - Lifecycle

    init(networkClient: UserNetworkClientProtocol = UserNetworkClient()) {
        self.networkClient = networkClient
        
        self.networkClient.resultHandler = self
    }
    
    // MARK: - Public Functions
    
    func user(forUserName username: String) {
        networkClient.user(forUsername: username)
    }
    
    // MARK: - UserNetworkClientResultHandler Conformance
    
    func userRequestDidSucceed(_ user: UserProtocol) {
        Log.debug(user)
    }
    
    func userRequestDidFailed(_ error: Error) {
        Log.error(error)
    }
}
