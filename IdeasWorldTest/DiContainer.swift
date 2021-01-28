//
//  DiContainer.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

enum DiContainer {
    // swiftlint:disable:next force_unwrapping
    static let api = DecoderPlist().api()!
    static let coreData = CoreDataStore()
}
