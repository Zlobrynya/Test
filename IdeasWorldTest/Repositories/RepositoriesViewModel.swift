//
//  RepositoriesViewModel.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Combine
import Foundation

class RepositoriesViewModel: ObservableObject, RepositoriesNetworkClientResultHandler {

    // MARK: - Public Properties

    @Published var repositories = [RepositoryProtocol]()

    // MARK: - Private Properties

    private var page: Int?
    private var searchName: String?

    // MARK: - External Dependencies

    private let networkClient: RepositoriesNetworkClientProtocol
    private let constants: RepositoriesConstantsProtocol

    // MARK: - Lifecycle

    init(
        networkClient: RepositoriesNetworkClientProtocol = RepositoriesNetworkClient(),
        constants: RepositoriesConstantsProtocol = RepositoriesConstants()
    ) {
        self.networkClient = networkClient
        self.constants = constants

        self.networkClient.resultHandler = self
    }

    // MARK: - Public Functions

    func loadMore(number: Int) {
        guard number > repositories.count - 10, let search = searchName else { return }
        page = (repositories.count / constants.countInPage) + 1
        self.search(forName: search)
    }

    func search(forName name: String) {
        networkClient.repositories(forName: name, andPage: page, andCountPerPage: constants.countInPage)
    }

    // MARK: - RepositoriesNetworkClientResultHandler Conformance

    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol]) {
        Log.debug("repositories: \(repositories.count)")
        self.repositories = repositories
    }

    func repositoriesRequestDidFailed(_ error: Error) {
        Log.error("repositoriesRequestDidFailed \(error)")
    }
}
