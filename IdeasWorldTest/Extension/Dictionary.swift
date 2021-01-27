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
            guard let value = value as? String else { return nil }
            return URLQueryItem(name: key, value: value)
        }
    }
}
