//
//  DetailInfoView.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import SwiftUI

struct DetailInfoView: View {

    // MARK: - External Dependencies

    @ObservedObject var viewModel: DetailInfoViewModel

    // MARK: - Body

    var body: some View {
        Form {
            section(header: "Repository name", info: viewModel.repository.name)
            section(header: "Repository description", info: viewModel.repository.description)
            section(header: "User's name", info: viewModel.repository.user?.name)
            section(header: "User's email", info: viewModel.repository.user?.email)
        }
        .navigationBarItems(trailing: favoriteButton)
        .onAppear { self.viewModel.onAppear() }
    }

    // MARK: - Optional Views

    func section(header: String, info: String?) -> AnyView? {
        guard let info = info else { return nil }
        return AnyView(
            Section(header: Text(header)) {
                Text(info)
            }
        )
    }

    var favoriteButton: some View {
        Button(
            action: { viewModel.favourite() },
            label: {
                Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                    .padding()
            }
        )
    }
}

struct DetailInfoView_Previews: PreviewProvider {

    static let repository = Repository(
        id: 1,
        name: "Test",
        username: "1",
        description: "Test tset st s",
        user: User(id: 2, name: "Test Name", email: "Tets email")
    )

    static var previews: some View {
        DetailInfoView(viewModel: DetailInfoViewModel(repository: repository))
    }
}
