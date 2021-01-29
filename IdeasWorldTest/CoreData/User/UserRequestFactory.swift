//
//  UserRequestFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import CoreData
import Foundation

protocol UserRequestFactoryProtocol {
    /// Instantiates and returns a `NSFetchRequest<UserEntity>` for user by id.
    ///
    /// - Returns: The instantiated `NSFetchRequest<UserEntity>`
    func user(byId id: Int) -> NSFetchRequest<UserEntity>
}

struct UserRequestFactory: UserRequestFactoryProtocol {

    // MARK: - Public Functions

    func user(byId id: Int) -> NSFetchRequest<UserEntity> {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %ld", id)
        return request
    }
}
