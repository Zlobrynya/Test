//
//  RepositoryRequestFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import CoreData
import Foundation

protocol RepositoryRequestFactoryProtocol {
    /// Instantiates and returns a `NSFetchRequest<RepositoryEntity>` for all repositories.
    ///
    /// - Returns: The instantiated `NSFetchRequest<RepositoryEntity>`
    func repositories() -> NSFetchRequest<RepositoryEntity>
    
    /// Instantiates and returns a `NSFetchRequest<RepositoryEntity>` for repository by id.
    ///
    /// - Returns: The instantiated `NSFetchRequest<RepositoryEntity>`
    func repository(byId id: Int) -> NSFetchRequest<RepositoryEntity>
}

struct RepositoryRequestFactory: RepositoryRequestFactoryProtocol {

    // MARK: - Public Functions

    func repositories() -> NSFetchRequest<RepositoryEntity> {
        RepositoryEntity.fetchRequest()
    }
    
    func repository(byId id: Int) -> NSFetchRequest<RepositoryEntity> {
        let request: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %ld", id)
        return request
    }
}
