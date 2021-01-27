//
//  Repository.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol RepositoryProtocol: Codable {
    var id: Int { get }
    var name: String { get }
}

struct Repository: RepositoryProtocol {
    // MARK: - Public Properties

    let id: Int
    let name: String
}
