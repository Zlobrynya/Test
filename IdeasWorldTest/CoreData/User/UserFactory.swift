//
//  UserFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol UserFactoryProtocol {
    /// Instantiates a new `UserEntity` in the passed `NSManagedObjectContext`.
    ///
    /// - Parameter context: The `NSManagedObjectContext` in which to instantiate the `UserEntity`.
    /// - Returns: The instantiated `UserEntity`
    func entity(in context: NSManagedObjectContext) -> UserEntity
    
    /// Instantiates a new `UserProtocol` from the passed `UserEntity`.
    ///
    /// - Parameter entity: The `UserEntity`
    /// - Returns: The instantiated `UserProtocol`
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
