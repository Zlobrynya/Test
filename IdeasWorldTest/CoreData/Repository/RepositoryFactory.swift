//
//  RepositoryFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol RepositoryFactoryProtocol {
    /// Instantiates a new `RepositoryEntity` in the passed `NSManagedObjectContext`.
    ///
    /// - Parameter context: The `NSManagedObjectContext` in which to instantiate the `RepositoryEntity`.
    /// - Returns: The instantiated `RepositoryEntity`
    func entity(in context: NSManagedObjectContext) -> RepositoryEntity
    
    /// Instantiates a new `RepositoryProtocol` from the passed `RepositoryEntity`.
    ///
    /// - Parameter entity: The `RepositoryEntity`
    /// - Returns: The instantiated `RepositoryProtocol`
    func repository(entity: RepositoryEntity?) -> RepositoryProtocol?
}

struct RepositoryFactory: RepositoryFactoryProtocol {

    // MARK: - External Dependencies

    private let userFactory: UserFactoryProtocol

    // MARK: - Lifecycle

    init(userFactory: UserFactoryProtocol = UserFactory()) {
        self.userFactory = userFactory
    }

    // MARK: - Public Functions

    func entity(in context: NSManagedObjectContext) -> RepositoryEntity {
        RepositoryEntity(context: context)
    }

    func repository(entity: RepositoryEntity?) -> RepositoryProtocol? {
        guard
            let entity = entity,
            let id = entity.id as? Int,
            let name = entity.name,
            let username = entity.username
        else { return nil }

        return Repository(
            id: id,
            name: name,
            username: username,
            description: entity.definition,
            user: userFactory.user(entity: entity.user)
        )
    }
}
