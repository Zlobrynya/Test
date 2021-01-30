//
//  DetailInfoViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 30.01.2021.
//

import Combine
import UIKit

class DetailInfoViewController: UIViewController {

    // MARK: - External Dependencies

    private var name: RowInfoView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        name = RowInfoView(frame: view.frame, header: "Name", message: "Message")
        name.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(name)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.onAppear()
    }

    // MARK: - Private Properties
    
}
