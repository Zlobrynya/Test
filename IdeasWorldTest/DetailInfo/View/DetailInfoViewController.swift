//
//  DetailInfoViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 30.01.2021.
//

import Combine
import UIKit

class DetailInfoViewController: UIViewController {

    // MARK: - Private Properties

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - External Dependencies

    var viewModel: DetailInfoViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        navigationItem.title = "Repository Information"
        updateConstraint(view: stackView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onAppear()
        sinkRepository()
        sinkIsFavorite()
    }

    // MARK: - View

    private lazy var nameRow: RowInfoView = {
        let row = RowInfoView(frame: view.frame, header: "Name")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()

    private lazy var descriptionRow: RowInfoView = {
        let row = RowInfoView(frame: view.frame, header: "Desctiption")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()

    private lazy var userNameRow: RowInfoView = {
        let row = RowInfoView(frame: view.frame, header: "Username")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()

    private lazy var emailNameRow: RowInfoView = {
        let row = RowInfoView(frame: view.frame, header: "Email")
        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Private Functions

    private func sinkRepository() {
        viewModel.$repository
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                guard let self = self else { return }
                self.nameRow.message = item.name
                self.stackView.addArrangedSubview(self.nameRow)
                self.setDescription(item.description)
                self.setUser(item.user)
            }
            .store(in: &subscriptions)
    }

    private func sinkIsFavorite() {
        viewModel.$isFavorite
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                guard let self = self else { return }
                let systemName = item ? "star.fill" : "star"
                let favourite = UIButton(type: .custom)
                favourite.setImage(UIImage(systemName: systemName), for: .normal)
                favourite.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                favourite.addTarget(self, action: #selector(self.favourite), for: .touchUpInside)
                self.navigationItem.setRightBarButton(UIBarButtonItem(customView: favourite), animated: true)
            }
            .store(in: &subscriptions)
    }

    @objc
    private func favourite() {
        viewModel.favourite()
    }

    private func setUser(_ user: UserProtocol?) {
        guard let user = user else { return }
        userNameRow.message = user.name
        stackView.addArrangedSubview(userNameRow)
        guard let email = user.email else { return }
        emailNameRow.message = email
        stackView.addArrangedSubview(userNameRow)
    }

    private func setDescription(_ description: String?) {
        guard let description = description else { return }
        descriptionRow.message = description
        stackView.addArrangedSubview(descriptionRow)
    }

    private func updateConstraint(view: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}
