//
//  RepositoriesView.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import SwiftUI

struct RepositoriesView: View {

    // MARK: - External Dependencies

    @ObservedObject var viewModel: RepositoriesViewModel

    // MARK: - Body

    var body: some View {
        NavigationView {
            main
                .navigationBarSearch($viewModel.search, placeholder: "Search repository")
                .navigationBarTitle("Search", displayMode: .inline)
                .alert(isPresented: $viewModel.isPresentErrorAlert) {
                    Alert(title: Text(viewModel.errorMessage))
                }
                .onAppear { viewModel.onAppear() }
        }
    }

    // MARK: - Views

    private var main: some View {
        Form {
            Section(header: header) {
                if viewModel.isLoading, !viewModel.isLoadMore {
                    activityIndicator
                } else {
                    repositories
                    activityIndicator
                }
            }
        }
    }

    private var header: some View {
        Text(
            viewModel.favouriteRepositories
                ? "Favourite repositories"
                : "Search repositories"
        )
    }

    // MARK: - Optional Views

    private var repositories: AnyView? {
        if viewModel.repositories.isEmpty {
            return Text("Don't have repositories.").asAnyView()
        } else {
            return ForEach(Array(viewModel.repositories.enumerated()), id: \.offset) { index, item in
                NavigationLink(
                    item.name,
                    destination: DetailInfoView(viewModel: viewModel.detailViewModel(withRepository: item))
                ).onAppear { viewModel.loadMore(number: index) }
            }.asAnyView()
        }
    }

    private var activityIndicator: AnyView? {
        guard viewModel.isLoading else { return nil }
        return ActivityIndicator(isAnimating: $viewModel.isLoading, style: .medium).asAnyView()
    }
}

struct RepositoriesView_Previews: PreviewProvider {

    @ObservedObject static var viewModel = MockRepositoriesViewMode()

    static var previews: some View {
        RepositoriesView(viewModel: viewModel)
    }
}
