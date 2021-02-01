//
//  RepositoryCoreData.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import Foundation

protocol RepositoryCoreDataProtocol {
    ///  Saving a repository to a Core Data.
    ///
    /// - Parameter repository: Repository Data
    func store(_ repository: RepositoryProtocol)

    ///  Getting all repositories from the Core Data
    func repository() -> [RepositoryProtocol]

    ///  Getting a repository by id.
    ///
    /// - Parameter id: Repository's id
    /// - Returns: Repository Data
    func repository(byId id: Int) -> RepositoryProtocol?

    ///  Deleting a repository by id from Core Data.
    ///
    /// - Parameter id: Repository's id
    func remove(byId id: Int)
    
    ///  Checking that such a repository exists in the Core Data.
    ///
    /// - Parameter id: Repository's id
    func hasRepository(byId id: Int) -> Bool
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

    func remove(byId id: Int) {
        let request = requestFactory.repository(byId: id)
        coreDataStore.performOnBackgroundQueue { context in
            do {
                let repositoriesEntity = try context.fetch(request)
                repositoriesEntity.forEach {
                    context.delete($0)
                }
            } catch {
                Log.error(error)
            }
        }
    }
    
    func hasRepository(byId id: Int) -> Bool {
        repository(byId: id) != nil
    }
}
