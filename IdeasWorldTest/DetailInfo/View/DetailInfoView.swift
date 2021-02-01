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
    @EnvironmentObject var stringProvider: StringLocalizable

    // MARK: - Body

    var body: some View {
        Form {
            section(header: stringProvider.repositoryName, info: viewModel.repository.name)
            section(header: stringProvider.repositoryDescription, info: viewModel.repository.description)
            section(header: stringProvider.username, info: viewModel.repository.user?.name)
            section(header: stringProvider.userEmail, info: viewModel.repository.user?.email)
        }
        .navigationBarTitle(Text(stringProvider.repositoryInformationTitle), displayMode: .inline)
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
