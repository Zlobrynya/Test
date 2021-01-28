//
//  DecoderPlist.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol DecoderPlistProtocol {
    func api() -> ApiProtocol?
}

struct DecoderPlist: DecoderPlistProtocol {

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

    func api() -> ApiProtocol? {
        guard
            let path = bundle.path(forResource: "Api", ofType: "plist"),
            let xml = fileManager.contents(atPath: path),
            let api = try? propertyListDecoder.decode(Api.self, from: xml)
        else {
            return nil
        }
        return api
    }
}
