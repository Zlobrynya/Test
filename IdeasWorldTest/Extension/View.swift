//
//  View.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import SwiftUI

extension View {

    /// Attaches the  `UISearchViewController` to a view
    func navigationBarSearch(_ searchText: Binding<String>, placeholder: String? = nil) -> some View {
        overlay(SearchBarView(text: searchText, placeholder: placeholder).frame(width: 0, height: 0))
    }
    
    func asAnyView() -> AnyView {
        AnyView(self)
    }
}
