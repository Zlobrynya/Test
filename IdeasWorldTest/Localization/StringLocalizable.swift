//
//  StringLocalizable.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Combine
import Foundation

class StringLocalizable: ObservableObject {
    var repositoryName: String {
        NSLocalizedString("repositoryName", bundle: .main, comment: "")
    }

    var repositoryDescription: String {
        NSLocalizedString("repositoryDescription", bundle: .main, comment: "")
    }

    var userEmail: String {
        NSLocalizedString("userEmail", bundle: .main, comment: "")
    }

    var username: String {
        NSLocalizedString("username", bundle: .main, comment: "")
    }

    var searchRepositories: String {
        NSLocalizedString("searchRepositories", bundle: .main, comment: "")
    }

    var favouriteRepositories: String {
        NSLocalizedString("favouriteRepositories", bundle: .main, comment: "")
    }

    var doNotHaveRepositories: String {
        NSLocalizedString("doNotHaveRepositories", bundle: .main, comment: "")
    }

    var searchTitle: String {
        NSLocalizedString("searchTitle", bundle: .main, comment: "")
    }

    var repositoryInformationTitle: String {
        NSLocalizedString("repositoryInformationTitle", bundle: .main, comment: "")
    }

    var placeholderSearch: String {
        NSLocalizedString("placeholderSearch", bundle: .main, comment: "")
    }
}
