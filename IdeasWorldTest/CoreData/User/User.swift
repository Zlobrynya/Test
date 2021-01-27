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
    
    // MARK: - Public Properties
    
    let id: Int
    let name: String
    let email: String?
}
