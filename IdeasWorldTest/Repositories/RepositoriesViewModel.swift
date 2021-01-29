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
    var search = "" { didSet { searchRepos() } }

    // MARK: - Private Properties

    private var page: Int?
    private var searchName: String?
    private var selectRepositories: RepositoryProtocol?

    // MARK: - External Dependencies

    private let networkClient: RepositoriesNetworkClientProtocol
    private let constants: RepositoriesConstantsProtocol
    private let repositoryCoreData: RepositoryCoreDataProtocol
    private let detailInfoFactory: DetailInfoFactoryProtocol

    // MARK: - Lifecycle

    init(
        networkClient: RepositoriesNetworkClientProtocol = RepositoriesNetworkClient(),
        constants: RepositoriesConstantsProtocol = RepositoriesConstants(),
        repositoryCoreData: RepositoryCoreDataProtocol = RepositoryCoreData(),
        detailInfoFactory: DetailInfoFactoryProtocol = DetailInfoFactory()
    ) {
        self.networkClient = networkClient
        self.repositoryCoreData = repositoryCoreData
        self.constants = constants
        self.detailInfoFactory = detailInfoFactory

        self.networkClient.resultHandler = self
    }

    func onAppear() {
        repositories = repositoryCoreData.repository()
    }

    // MARK: - Public Functions

    func loadMore(number: Int) {
        guard number > repositories.count - 10, let search = searchName else { return }
        page = (repositories.count / constants.countInPage) + 1
//        self.search(forName: search)
    }

    func detailViewModel() -> DetailInfoViewModel? {
        guard let selectRepositories = selectRepositories else { return nil }
        return detailInfoFactory.viewModel(repository: selectRepositories)
    }

    // MARK: - RepositoriesNetworkClientResultHandler Conformance

    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol]) {
        Log.debug("repositories: \(repositories.count)")
        DispatchQueue.main.async {
            self.repositories = repositories
        }
    }

    func repositoriesRequestDidFailed(_ error: Error) {
        Log.error("repositoriesRequestDidFailed \(error)")
    }

    // MARK: - Private Functions

    private func searchRepos() {
        guard !search.isEmpty else { return }
        networkClient.repositories(forName: search, andPage: page, andCountPerPage: constants.countInPage)
    }
}
