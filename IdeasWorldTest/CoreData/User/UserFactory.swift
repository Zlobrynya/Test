//
//  UserFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol UserFactoryProtocol {
    func entity(in context: NSManagedObjectContext) -> UserEntity
    func user(entity: UserEntity?) -> UserProtocol?
}

struct UserFactory: UserFactoryProtocol {

    // MARK: - Public Functions

    func entity(in context: NSManagedObjectContext) -> UserEntity {
        UserEntity(context: context)
    }

    func user(entity: UserEntity?) -> UserProtocol? {
        guard let entity = entity, let id = entity.id as? Int, let name = entity.name
        else { return nil }
        return User(id: id, name: name, email: entity.email)
    }
}
