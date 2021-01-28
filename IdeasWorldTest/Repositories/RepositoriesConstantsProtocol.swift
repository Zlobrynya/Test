//
//  RepositoriesConstantsProtocol.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol RepositoriesConstantsProtocol {
    var repositories: String { get }
    var countInPage: Int { get }
}

struct RepositoriesConstants: RepositoriesConstantsProtocol {

    // MARK: - Public Properties
    
    let repositories: String
    let countInPage = 50
    
    // MARK: - Lifecycle

    init(api: ApiProtocol = DiContainer.api) {
        repositories = api.url + api.repositories
    }
}
