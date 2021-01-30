//
//  ViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = DetailInfoViewModel(repository: Repository(id: 2, name: "name", username: "username"))

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.user(forUserName: "Zlobrynya")
    }

    @IBAction func test(_ sender: Any) {}
}
