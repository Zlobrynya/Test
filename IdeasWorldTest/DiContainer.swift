//
//  DiContainer.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

enum DiContainer {
    // swiftlint:disable:next force_unwrapping
    static let api = DecoderPlist<Api>().plist(byName: "Api")!
    
    // swiftlint:disable:next force_unwrapping
    static let tokens = DecoderPlist<Tokens>().plist(byName: "Tokens")!
    
    static let coreData = CoreDataStore()
}
