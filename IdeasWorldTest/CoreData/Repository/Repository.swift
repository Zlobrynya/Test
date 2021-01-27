//
//  Repository.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol RepositoryProtocol: Decodable {
    var id: Int { get }
    var name: String { get }
    var userId: Int { get }
    var description: String? { get }
    var user: UserProtocol? { get }
}

struct Repository: RepositoryProtocol {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
    }

    // MARK: - Public Properties

    let id: Int
    let name: String
    let userId: Int
    let description: String?
    var user: UserProtocol?

    // MARK: - Lifecycle

    init(
        id: Int,
        name: String,
        userId: Int,
        description: String? = nil,
        user: UserProtocol? = nil
    ) {
        self.id = id
        self.name = name
        self.userId = userId
        self.description = description
        self.user = user
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        let owner = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        userId = try owner.decode(Int.self, forKey: .id)
        user = nil
    }
}
