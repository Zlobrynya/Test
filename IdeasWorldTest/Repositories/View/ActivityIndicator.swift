//
//  ActivityIndicator.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    // MARK: - Private Properties

    @Binding private var isAnimating: Bool
    private let style: UIActivityIndicatorView.Style
    private let color: UIColor?

    // MARK: - Lifecycle

    init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        _isAnimating = isAnimating
        self.style = style
        self.color = color
    }

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        if let color = color {
            indicator.color = color
        }
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
