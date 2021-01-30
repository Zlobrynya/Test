//
//  RowInfoView.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 30.01.2021.
//

import UIKit

class RowInfoView: UIView {

    // MARK: - Private Properties

    private let headerLabel: UILabel!
    private let textLabel: UILabel!
    private let stackView: UIStackView!

    // MARK: - Lifecycle

    init(frame: CGRect, header: String, message: String) {
        headerLabel = UILabel(frame: .zero)
        textLabel = UILabel(frame: .zero)
        headerLabel.text = header
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = message
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(textLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        super.init(frame: frame)
        addSubview(stackView)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        headerLabel = UILabel(frame: .zero)
        textLabel = UILabel(frame: .zero)
        stackView = UIStackView()
        super.init(coder: aDecoder)
        Log.debug("    required init?(coder aDecoder: NSCoder) ")
    }

    // MARK: - Private Functions

    private func updateConstraint() {
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            // pin headerTitle to headerView
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),

//        textLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
//        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
//        textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
//        textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override var intrinsicContentSize: CGSize {
        // preferred content size, calculate it if some internal state changes
        return CGSize(width: frame.width, height: 300)
    }
}
