//
//  RepositoriesViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Combine
import UIKit

class RepositoriesViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating {

    // MARK: - Private Properties

    private var tableView: UITableView!
    private let searchController = UISearchController()
    private var activityIndicator: UIActivityIndicatorView!
    private var subscriptions = Set<AnyCancellable>()
    
    private let identifierTableCell = "TableViewCell"

    // MARK: - External Dependencies

    var viewModel: RepositoriesViewModel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Table"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        activityIndicator = UIActivityIndicatorView()
        createTableView()
        createSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.onAppear()
        viewModel.$repositories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] item in
                Log.debug(item)
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                isLoading ?
                    self?.activityIndicator.startAnimating() :
                    self?.activityIndicator.stopAnimating()
            }
            .store(in: &subscriptions)
    }

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

    // MARK: - UISearchResultsUpdating Conformance

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.search = text
    }

    // MARK: - Private Functions

    private func createSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.sizeToFit()
    }

    private func createTableView() {
        tableView = UITableView(frame: .zero, style: UITableView.Style.grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifierTableCell)
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        updateConstraint()
    }

    private func updateConstraint() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
