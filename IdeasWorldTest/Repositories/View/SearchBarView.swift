//
//  SearchBarView.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import SwiftUI

struct SearchBarView: UIViewControllerRepresentable {

    // MARK: - External Dependencies

    @Binding var text: String
    let placeholder: String?

    // MARK: - Lifecycle

    init(text: Binding<String>, placeholder: String?) {
        _text = text
        self.placeholder = placeholder
    }

    // MARK: - Public functions

    func makeUIViewController(context: Context) -> SearchBarController {
        let searchBar = SearchBarController()
        searchBar.placeholder = placeholder
        searchBar.resultsUpdater = context.coordinator
        return searchBar
    }

    func updateUIViewController(_ controller: SearchBarController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, UISearchResultsUpdating {

        // MARK: - External Dependencies

        @Binding var text: String

        // MARK: - Lifecycle

        init(text: Binding<String>) {
            _text = text
        }

        // MARK: - UISearchResultsUpdating Conformance

        func updateSearchResults(for searchController: UISearchController) {
            guard let text = searchController.searchBar.text, text != self.text else { return }
            self.text = text
        }
    }

    // MARK: - SearchBarController

    final class SearchBarController: UIViewController {

        // MARK: - Public Properties

        weak var resultsUpdater: UISearchResultsUpdating?
        var placeholder: String?

        // MARK: - Lifecycle

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            setup()
        }

        // MARK: - Private Functions

        private func setup() {
            guard let parent = parent, parent.navigationItem.searchController == nil else { return }

            parent.navigationItem.searchController = UISearchController()
            parent.navigationItem.hidesSearchBarWhenScrolling = false

            guard let searchController = parent.navigationItem.searchController else { return }

            searchController.hidesNavigationBarDuringPresentation = true
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchResultsUpdater = resultsUpdater
            searchController.searchBar.placeholder = placeholder

            parent.navigationController?.navigationBar.sizeToFit()
        }
    }
}
