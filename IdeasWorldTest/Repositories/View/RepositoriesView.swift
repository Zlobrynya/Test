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
                .onAppear { viewModel.onAppear() }
        }
    }

    // MARK: - Views

    private var main: some View {
        Form {
            ForEach(viewModel.repositories, id: \.id) {
                NavigationLink($0.name, destination: Text("Test"))
            }
        }
    }
    
}

struct RepositoriesView_Previews: PreviewProvider {

    @ObservedObject static var viewModel = MockRepositoriesViewMode()

    static var previews: some View {
        RepositoriesView(viewModel: viewModel)
    }
}
