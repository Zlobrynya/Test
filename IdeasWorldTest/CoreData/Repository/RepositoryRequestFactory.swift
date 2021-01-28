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
}

struct RepositoryRequestFactory: RepositoryRequestFactoryProtocol {

    // MARK: - Public Functions

    func repositories() -> NSFetchRequest<RepositoryEntity> {
        RepositoryEntity.fetchRequest()
    }
}
