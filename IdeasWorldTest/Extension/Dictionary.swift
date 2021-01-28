//
//  Dictionary.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    ///  Converts from a dictionary to URLQueryItems
    ///
    /// - Returns: array `URLQueryItem`
    func asURLQueryItem() -> [URLQueryItem] {
        compactMap { key, value in
            if let valueAsString = value as? String { return URLQueryItem(name: key, value: valueAsString) }
            let mirror = Mirror(reflecting: value)
            guard mirror.displayStyle == .optional else {
                return URLQueryItem(name: key, value: String(describing: value))
            }
            guard let value = mirror.children.first?.value else { return nil }
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
