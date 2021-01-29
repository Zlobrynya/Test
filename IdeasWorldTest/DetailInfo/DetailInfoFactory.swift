//
//  DetailInfoFactory.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import Foundation

protocol DetailInfoFactoryProtocol {
    func viewModel(repository: RepositoryProtocol) -> DetailInfoViewModel
}

struct DetailInfoFactory: DetailInfoFactoryProtocol {
    func viewModel(repository: RepositoryProtocol) -> DetailInfoViewModel {
        DetailInfoViewModel(repository: repository)
    }
}
