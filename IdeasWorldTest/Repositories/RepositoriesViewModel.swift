//
//  SearchViewModel.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

class SearchViewModel: RepositoriesNetworkClientResultHandler {

    // MARK: - Private Properties

    private let page: Int? = nil

    // MARK: - External Dependencies

    private let networkClient: RepositoriesNetworkClientProtocol

    // MARK: - Lifecycle

    init(networkClient: RepositoriesNetworkClientProtocol = RepositoriesNetworkClient()) {
        self.networkClient = networkClient

        self.networkClient.resultHandler = self
    }

    // MARK: - Public Functions

    func search(forName name: String) {
        networkClient.repositories(forName: name, andPage: page, andCountPerPage: 50)
    }

    // MARK: - RepositoriesNetworkClientResultHandler Conformance

    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol]) {
        Log.debug("repositories: \(repositories.count)")
    }

    func repositoriesRequestDidFailed(_ error: Error) {
        Log.error("repositoriesRequestDidFailed \(error)")
    }
}
