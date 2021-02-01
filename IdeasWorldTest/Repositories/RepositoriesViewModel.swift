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
    @Published var isPresentErrorAlert = false
    @Published var isLoading = false
    var errorMessage = "" { didSet { isPresentErrorAlert = true } }

    var favouriteRepositories = true
    var isLoadMore: Bool { (page ?? 0) > 1 }

    var search = "" {
        didSet {
            page = 0
            searchRepositories()
        }
    }

    // MARK: - Private Properties

    private var page: Int?
    private var searchName: String?
    private var selectRepositories: RepositoryProtocol?

    // MARK: - External Dependencies

    private let networkClient: RepositoriesNetworkClientProtocol
    private let constants: RepositoriesConstantsProtocol
    private let repositoryCoreData: RepositoryCoreDataProtocol
    private let detailInfoFactory: DetailInfoFactoryProtocol
    private let throttler: ThrottlerProtocol

    // MARK: - Lifecycle

    init(
        networkClient: RepositoriesNetworkClientProtocol = RepositoriesNetworkClient(),
        constants: RepositoriesConstantsProtocol = RepositoriesConstants(),
        repositoryCoreData: RepositoryCoreDataProtocol = RepositoryCoreData(),
        detailInfoFactory: DetailInfoFactoryProtocol = DetailInfoFactory(),
        throttler: ThrottlerProtocol = Throttler(minimumDelay: 0.3)
    ) {
        self.networkClient = networkClient
        self.repositoryCoreData = repositoryCoreData
        self.constants = constants
        self.throttler = throttler
        self.detailInfoFactory = detailInfoFactory

        self.networkClient.resultHandler = self
    }

    func onAppear() {
        guard search.isEmpty else { return }
        setFavouriteRepositories()
    }

    // MARK: - Public Functions

    func loadMore(number: Int) {
        guard repositories.count > constants.countInPage, number > repositories.count - 10, !search.isEmpty else { return }
        page = (repositories.count / constants.countInPage) + 1
        searchRepositories()
    }

    func detailViewModel(withRepository repository: RepositoryProtocol) -> DetailInfoViewModel {
        detailInfoFactory.viewModel(repository: repository)
    }

    // MARK: - RepositoriesNetworkClientResultHandler Conformance

    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol]) {
        favouriteRepositories = false
        DispatchQueue.main.async {
            self.isLoading = false
            if self.isLoadMore {
                self.repositories.append(contentsOf: repositories)
            } else {
                self.repositories = repositories
            }
        }
    }

    func repositoriesRequestDidFailed(_ error: Error) {
        Log.error("repositoriesRequestDidFailed \(error)")
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = "Something's wrong"
        }
    }

    // MARK: - Private Functions

    private func searchRepositories() {
        throttler.throttle { [weak self] in
            guard let self = self else { return }
            self.networkClient.cancelRequest()
            if self.search.isEmpty {
                self.setFavouriteRepositories()
            } else {
                self.favouriteRepositories = false
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                self.networkClient.repositories(
                    forName: self.search,
                    andPage: self.page,
                    andCountPerPage: self.constants.countInPage
                )
            }
        }
    }

    private func setFavouriteRepositories() {
        DispatchQueue.main.async {
            self.favouriteRepositories = true
            self.repositories = self.repositoryCoreData.repository()
        }
    }
}
