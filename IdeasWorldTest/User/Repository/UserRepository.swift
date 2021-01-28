//
//  UserRepository.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation
import CoreData

protocol UserRepositoryProtocol {
    func store(user: UserProtocol, in context: NSManagedObjectContext)
}

struct UserRepository: UserRepositoryProtocol {

    // MARK: - External Dependencies

    private let coreDataStore: CoreDataStoreProtocol
    private let userFactory: UserFactoryProtocol

    // MARK: - Lifecycle

    init(
        coreDataStore: CoreDataStoreProtocol = DiContainer.coreData,
        userFactory: UserFactoryProtocol = UserFactory()
    ) {
        self.coreDataStore = coreDataStore
        self.userFactory = userFactory
    }

    // MARK: - Public Functions

    func store(user: UserProtocol, in context: NSManagedObjectContext) {
        let userEntity = userFactory.entity(in: context)
        userEntity.email = user.email
        userEntity.id = user.id as NSNumber
        userEntity.name = user.name
    }
}
