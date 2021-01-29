//
//  DetailInfoViewModel.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Combine
import Foundation

class DetailInfoViewModel: ObservableObject, UserNetworkClientResultHandler {

    // MARK: - Public Properties

    @Published var isFavorite = false

    // MARK: - External Dependencies

    private let networkClient: UserNetworkClientProtocol
    private let repositoryCoreData: RepositoryCoreDataProtocol
    @Published var repository: RepositoryProtocol

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

    func onAppear() {
        isFavorite = repositoryCoreData.repository(byId: repository.id) != nil
        networkClient.user(forUsername: repository.username)

    }

    // MARK: - Public Functions

    func user(forUserName username: String) {
        networkClient.user(forUsername: username)
    }

    func favourite() {
        isFavorite.toggle()
        if isFavorite {
            repositoryCoreData.store(repository)
        } else {
            
        }
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
