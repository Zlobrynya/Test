//
//  SearchParameters.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

struct SearchParameters: ParametersProtocol {

    // MARK: - Public Properties

    var q: String?
    var page: Int?
    // swiftlint:disable:next identifier_name
    let per_page: Int
}
