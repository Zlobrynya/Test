//
//  Api.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol ApiProtocol: Codable {
    var url: String { get }
    var repositories: String { get }
    var user: String { get }
}

struct Api: ApiProtocol {
    let url: String
    let repositories: String
    let user: String
}
