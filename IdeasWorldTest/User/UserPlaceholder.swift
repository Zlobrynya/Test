//
//  UserPlaceholder.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol UserPlaceholderProtocol {
    var value: String { get }
}

struct UserPlaceholder: UserPlaceholderProtocol {
    let value = "{username}"
}
