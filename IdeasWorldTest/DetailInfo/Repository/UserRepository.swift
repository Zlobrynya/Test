//
//  UserRepository.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import CoreData
import Foundation

protocol UserRepositoryProtocol {
    ///  Store a user to core data.
    ///
    /// - Parameter user: User's data
    /// - Parameter context: Core data context
    func store(user: UserProtocol, in context: NSManagedObjectContext)

    /// Fetches the user entity with the given ID.
    ///
    /// - Parameter id: User identifier
    /// - Parameter context: Core data context
    /// - Returns: User entity
    func entity(byId id: Int, in context: NSManagedObjectContext) -> UserEntity?
}

struct UserRepository: UserRepositoryProtocol {

    // MARK: - External Dependencies

    private let coreDataStore: CoreDataStoreProtocol
    private let userFactory: UserFactoryProtocol
    private let userRequestFactory: UserRequestFactoryProtocol

    // MARK: - Lifecycle

    init(
        coreDataStore: CoreDataStoreProtocol = DiContainer.coreData,
        userFactory: UserFactoryProtocol = UserFactory(),
        userRequestFactory: UserRequestFactoryProtocol = UserRequestFactory()
    ) {
        self.coreDataStore = coreDataStore
        self.userFactory = userFactory
        self.userRequestFactory = userRequestFactory
    }

    // MARK: - Public Functions

    func store(user: UserProtocol, in context: NSManagedObjectContext) {
        let userEntity = userFactory.entity(in: context)
        userEntity.email = user.email
        userEntity.id = user.id as NSNumber
        userEntity.name = user.name
    }

    func entity(byId id: Int, in context: NSManagedObjectContext) -> UserEntity? {
        let request = userRequestFactory.user(byId: id)
        return try? context.fetch(request).first
    }
}
