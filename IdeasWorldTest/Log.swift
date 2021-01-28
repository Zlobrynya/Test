//
//  Log.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

enum Log {
    static func error(_ message: Any) {
        debugPrint("🔴 \(message)")
    }
    
    static func debug(_ message: Any) {
        debugPrint("🔵 \(message)")
    }
}
