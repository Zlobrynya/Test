//
//  Parameters.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol ParametersProtocol: Encodable {}

extension ParametersProtocol {
    var asDictionary: [String: Any] {
        let mirror = Mirror(reflecting: self)
        let dict = Dictionary(
            uniqueKeysWithValues: mirror.children.lazy.map { (label: String?, value: Any) -> (String, Any)? in
                guard let label = label else { return nil }
                return (label, value)
            }
            .compactMap { $0 }
        )
        return dict
    }
}
