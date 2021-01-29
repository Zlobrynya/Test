//
//  UserNetworkClient.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol UserNetworkClientResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter user: <#Parameter Description#>
    func userRequestDidSucceed(_ user: UserProtocol)

    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    func userRequestDidFailed(_ error: Error)
}

protocol UserNetworkClientProtocol: NetworkResultHandler {

    ///  <#Description#>
    ///
    /// - Parameter id: <#Parameter Description#>
    func user(forUsername username: String)

    ///  <#Description#>
    var resultHandler: UserNetworkClientResultHandler? { get set }
}

class UserNetworkClient: UserNetworkClientProtocol {

    // MARK: - External Dependencies

    weak var resultHandler: UserNetworkClientResultHandler?

    private let networkRequestFactory: NetworkRequestFactoryProtocol
    private let constants: UserConstantsProtocol
    private let jsonDecoder: JSONDecoder

    // MARK: - Lifecycle

    init(
        networkRequestFactory: NetworkRequestFactoryProtocol = NetworkRequestFactory(),
        constants: UserConstantsProtocol = UserConstants(),
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkRequestFactory = networkRequestFactory
        self.constants = constants
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Public Functions

    func user(forUsername username: String) {
        guard let url = URL(string: constants.userEndpoint(username)) else { return }
        
        do {
            let request = try networkRequestFactory.get(url: url, resultHandler: self)
            request.send()
        } catch {
            resultHandler?.userRequestDidFailed(error)
        }
    }

    // MARK: - NetworkResultHandler Conformance

    func requestFailedWithResult(_ result: Data) {
        do {
            let user = try jsonDecoder.decode(User.self, from: result)
            resultHandler?.userRequestDidSucceed(user)
        } catch {
            resultHandler?.userRequestDidFailed(error)
        }
    }

    func requestFailedWithError(_ error: Error) {
        resultHandler?.userRequestDidFailed(error)
    }
}
