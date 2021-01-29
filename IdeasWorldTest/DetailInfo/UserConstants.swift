//
//  UserConstants.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol UserConstantsProtocol {
    var userEndpoint: (String) -> String { get }
}

struct UserConstants: UserConstantsProtocol {

    // MARK: - Public Properties

    let userEndpoint: (String) -> String
    
    // MARK: - Lifecycle

    init(api: ApiProtocol = DiContainer.api, placeholder: UserPlaceholderProtocol = UserPlaceholder()) {
        userEndpoint = {
            api.url + api.user.replacingOccurrences(of: placeholder.value, with: $0)
        }
    }
}
