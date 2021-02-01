//
//  Tokens.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
 
protocol TokensProtocol: Codable {
    var github: String { get }
}

struct Tokens: TokensProtocol {
    let github: String
}
