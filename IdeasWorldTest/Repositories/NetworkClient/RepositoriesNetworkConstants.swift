//
//  RepositoriesNetworkConstants.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol RepositoriesNetworkConstantsProtocol {
    var repositories: String { get }
}

struct RepositoriesNetworkConstants: RepositoriesNetworkConstantsProtocol {

    // MARK: - Public Properties
    
    let repositories: String

    // MARK: - Lifecycle

    init(api: ApiProtocol = DiContainer.api) {
        repositories = api.url + api.repositories
    }
}
