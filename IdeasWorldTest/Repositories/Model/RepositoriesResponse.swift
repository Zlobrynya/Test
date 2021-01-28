//
//  RepositoriesResponse.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol RepositoriesResponseProtocol: Decodable {
    var items: [Repository] { get }
}

struct RepositoriesResponse: RepositoriesResponseProtocol {
    let items: [Repository]
}
