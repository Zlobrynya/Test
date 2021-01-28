//
//  RepositoryFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol RepositoryFactoryProtocol {
    func entity(in context: NSManagedObjectContext) -> RepositoryEntity
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
            let userId = entity.userId as? Int
        else { return nil }

        return Repository(
            id: id,
            name: name,
            userId: userId,
            description: entity.definition,
            user: userFactory.user(entity: entity.user)
        )
    }
}
