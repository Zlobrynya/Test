//
//  NetworkResultHandler.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

protocol NetworkResultHandler: AnyObject {
    ///  Called on a successful request.
    ///
    /// - Parameter data: Result Data
    func requestFailedWithResult(_ result: Data)
    
    ///  Called when an error occurs when sending a request.
    ///
    /// - Parameter error: Network error.
    func requestFailedWithError(_ error: Error)
}
