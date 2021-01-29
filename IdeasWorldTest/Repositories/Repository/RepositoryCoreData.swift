//
//  RepositoryCoreData.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import Foundation

protocol RepositoryCoreDataProtocol {
    func store(_ repository: RepositoryProtocol)

    func repository() -> [RepositoryProtocol]
    
    func repository(byId id: Int) -> RepositoryProtocol?
}

struct RepositoryCoreData: RepositoryCoreDataProtocol {

    // MARK: - External Dependencies

    private let coreDataStore: CoreDataStoreProtocol
    private let repositoryFactory: RepositoryFactoryProtocol
    private let requestFactory: RepositoryRequestFactoryProtocol
    private let userRepository: UserRepositoryProtocol

    // MARK: - Lifecycle

    init(
        coreDataStore: CoreDataStoreProtocol = DiContainer.coreData,
        userRepository: UserRepositoryProtocol = UserRepository(),
        repositoryFactory: RepositoryFactoryProtocol = RepositoryFactory(),
        requestFactory: RepositoryRequestFactoryProtocol = RepositoryRequestFactory()
    ) {
        self.coreDataStore = coreDataStore
        self.repositoryFactory = repositoryFactory
        self.requestFactory = requestFactory
        self.userRepository = userRepository
    }

    // MARK: - Public Functions

    func store(_ repository: RepositoryProtocol) {
        guard let user = repository.user else { return }
        coreDataStore.performOnBackgroundQueue { context in
            userRepository.store(user: user, in: context)
            let repositoryEntity = repositoryFactory.entity(in: context)
            repositoryEntity.id = repository.id as NSNumber
            repositoryEntity.name = repository.name
            repositoryEntity.username = repository.username
            repositoryEntity.definition = repository.description
            repositoryEntity.user = userRepository.entity(byId: user.id, in: context)
        }
    }

    func repository() -> [RepositoryProtocol] {
        let request = requestFactory.repositories()
        var repositories = [RepositoryProtocol]()
        do {
            try coreDataStore.performOnMainQueue { context in
                let repositoriesEntity = try context.fetch(request)
                repositories = repositoriesEntity.compactMap { repositoryFactory.repository(entity: $0) }
            }
        } catch {
            Log.error(error)
        }
        return repositories
    }
    
    func repository(byId id: Int) -> RepositoryProtocol? {
        let request = requestFactory.repository(byId: id)
        var repositories = [RepositoryProtocol]()
        do {
            try coreDataStore.performOnMainQueue { context in
                let repositoriesEntity = try context.fetch(request)
                repositories = repositoriesEntity.compactMap { repositoryFactory.repository(entity: $0) }
            }
        } catch {
            Log.error(error)
        }
        return repositories.first
    }
}
