//
//  RepositoriesViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Combine
import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, UITableViewDelegate {

    // MARK: - Private Properties

    private var subscriptions = Set<AnyCancellable>()
    private let identifierTableCell = "TableViewCell"
    private let stringLocalizable = StringLocalizable()

    // MARK: - External Dependencies

    var viewModel: RepositoriesViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = stringLocalizable.searchTitle
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        updateConstraint()
        createSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onAppear()
        linkRepositories()
        linkIsLoading()
        linkIsPresentErrorAlert()
    }

    // MARK: - Views

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifierTableCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundView = activityIndicator
        return tableView
    }()

    private lazy var searchController = UISearchController()
    private lazy var activityIndicator = UIActivityIndicatorView()

    // MARK: - UITableViewDataSource Conformance

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierTableCell, for: indexPath)
        cell.textLabel?.text = viewModel.repositories[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        viewModel.loadMore(number: indexPath.row)
        return cell
    }

    // MARK: - UITableViewDelegate Conformance

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel.detailViewModel(forIndex: indexPath.row) else { return }
        let viewController = DetailInfoViewController()
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - UISearchResultsUpdating Conformance

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.search = text
    }

    // MARK: - Private Functions

    private func linkRepositories() {
        viewModel.$repositories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }

    private func linkIsLoading() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ?
                    self?.activityIndicator.startAnimating() :
                    self?.activityIndicator.stopAnimating()
            }
            .store(in: &subscriptions)
    }

    private func linkIsPresentErrorAlert() {
        viewModel.$isPresentErrorAlert
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isPresentErrorAlert in
                guard let self = self, isPresentErrorAlert else { return }
                let alert = UIAlertController(
                    title: "Error",
                    message: self.viewModel.errorMessage,
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            .store(in: &subscriptions)
    }

    private func createSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
    }

    private func updateConstraint() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
