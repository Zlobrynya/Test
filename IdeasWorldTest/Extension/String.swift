//
//  String.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation

extension String {

    ///  Converts a string to an UInt8 array.
    ///
    /// - Returns: UInt8 array
    func toUInt8Array() -> [UInt8] {
        replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .compactMap { UInt8($0) }
    }
}
