//
//  NetworkConstants.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation

protocol NetworkConstantsProtocol {
    var authorizationHeader: String { get }
    var token: String { get }
}

struct NetworkConstants: NetworkConstantsProtocol {
    
    // MARK: - Public Properties
    
    let authorizationHeader = "Authorization"
    let token: String
    
    // MARK: - Lifecycle
    
    init(
        tokens: TokensProtocol = DiContainer.tokens,
        deobfuscator: DeobfuscatorProtocol = Deobfuscator()
    ) {
        token = "token \(deobfuscator.reveal(key: tokens.github.toUInt8Array()))"
    }
}
