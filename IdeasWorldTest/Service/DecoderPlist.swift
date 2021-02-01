//
//  DecoderPlist.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol DecoderPlistProtocol {
    associatedtype T: Codable
    
    ///  Decodes the plist into a structure.
    ///
    /// - Parameter name: Plist's name
    /// - Returns: Structure containing plist fields.
    func plist(byName name: String) -> T?
}

struct DecoderPlist<T: Codable>: DecoderPlistProtocol {

    // MARK: - External Dependencies

    private let bundle: Bundle
    private let fileManager: FileManager
    private let propertyListDecoder: PropertyListDecoder

    // MARK: - Lifecycle

    init(
        bundle: Bundle = Bundle.main,
        fileManager: FileManager = FileManager.default,
        propertyListDecoder: PropertyListDecoder = PropertyListDecoder()
    ) {
        self.bundle = bundle
        self.fileManager = fileManager
        self.propertyListDecoder = propertyListDecoder
    }

    // MARK: - Public Functions

    func plist(byName name: String) -> T? {
        guard
            let path = bundle.path(forResource: name, ofType: "plist"),
            let xml = fileManager.contents(atPath: path),
            let api = try? propertyListDecoder.decode(T.self, from: xml)
        else {
            return nil
        }
        return api
    }
}
