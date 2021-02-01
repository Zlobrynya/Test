//
//  Deobfuscator.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 01.02.2021.
//

import Foundation
import UIKit

/// https://gist.github.com/DejanEnspyra/80e259e3c9adf5e46632631b49cd1007

protocol DeobfuscatorProtocol {
    ///  This method reveals the original string from the obfuscated
    /// byte array passed in. The salt must be the same as the one
    /// used to encrypt it in the first place.
    ///
    /// - Parameter key: The byte array to reveal.
    /// - Returns: The original string.
    func reveal(key: [UInt8]) -> String
}

class Deobfuscator: DeobfuscatorProtocol {

    // MARK: - Private Properties
    
    /// The salt used to obfuscate and reveal the string.
    private var salt: String

    // MARK: - Lifecycle

    init(with bundle: Bundle = Bundle.main) {
        salt = bundle.bundlePath
    }

    // MARK: - Public Functions

    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](salt.utf8)
        let length = cipher.count

        var decrypted = [UInt8]()

        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        // swiftlint:disable:next force_unwrapping
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
