//
//  RowInfoView.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 30.01.2021.
//

import UIKit

class RowInfoView: UIView {

    // MARK: - External Dependencies

    var message: String = "" { didSet { textLabel.text = message } }

    // MARK: - Lifecycle

    init(frame: CGRect, header: String) {
        super.init(frame: frame)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(textLabel)
        headerLabel.text = header
        textLabel.text = " "
        addSubview(stackView)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Private Functions

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
