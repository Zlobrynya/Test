//
//  User.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol UserProtocol: Decodable {
    var id: Int { get }
    var name: String { get }
    var email: String? { get }
}

struct User: UserProtocol {

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case login
    }

    // MARK: - Public Properties

    let id: Int
    let name: String
    let email: String?

    // MARK: - Lifecycle

    init(id: Int, name: String, email: String?) {
        self.id = id
        self.name = name
        self.email = email
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        if let name = try? container.decode(String.self, forKey: .name) {
            self.name = name
        } else {
            name = try container.decode(String.self, forKey: .login)
        }
        email = try? container.decode(String.self, forKey: .email)
    }
}
