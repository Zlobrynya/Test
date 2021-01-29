//
//  DetailInfoViewModel.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

class DetailInfoViewModel: UserNetworkClientResultHandler {

    // MARK: - External Dependencies

    private let networkClient: UserNetworkClientProtocol
    private let repositoryCoreData: RepositoryCoreDataProtocol
    private var repository: RepositoryProtocol

    // MARK: - Lifecycle

    init(
        repository: RepositoryProtocol,
        networkClient: UserNetworkClientProtocol = UserNetworkClient(),
        repositoryCoreData: RepositoryCoreDataProtocol = RepositoryCoreData()
    ) {
        self.networkClient = networkClient
        self.repositoryCoreData = repositoryCoreData
        self.repository = repository

        self.networkClient.resultHandler = self
    }

    // MARK: - Public Functions

    func user(forUserName username: String) {
        networkClient.user(forUsername: username)
    }

    func favourite() {
        repositoryCoreData.store(repository)
    }

    func test() {
        Log.debug(repositoryCoreData.repository())
    }

    // MARK: - UserNetworkClientResultHandler Conformance

    func userRequestDidSucceed(_ user: UserProtocol) {
        Log.debug(user)
        repository.user = user
    }

    func userRequestDidFailed(_ error: Error) {
        Log.error(error)
    }
}
