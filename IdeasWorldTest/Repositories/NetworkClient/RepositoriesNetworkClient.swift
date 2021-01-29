//
//  RepositoriesNetworkClient.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol RepositoriesNetworkClientResultHandler: AnyObject {
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol])
    
    ///  <#Description#>
    ///
    /// - Parameter <#Name Parameter#>: <#Parameter Description#>
    func repositoriesRequestDidFailed(_ error: Error)
}

protocol RepositoriesNetworkClientProtocol: NetworkResultHandler {
    ///  <#Description#>
    ///
    /// - Parameter name: <#Parameter Description#>
    /// - Parameter page: <#Parameter Description#>
    func repositories(forName name: String, andPage page: Int?, andCountPerPage perPage: Int)
    
    func cancelRequest()

    ///  <#Description#>
    var resultHandler: RepositoriesNetworkClientResultHandler? { get set }
}

class RepositoriesNetworkClient: RepositoriesNetworkClientProtocol {
    
    
    // MARK: - Private Functions
    
    private var request: RequestProtocol?

    // MARK: - External Dependencies

    weak var resultHandler: RepositoriesNetworkClientResultHandler?

    private let networkRequestFactory: NetworkRequestFactoryProtocol
    private let constants: RepositoriesConstantsProtocol
    private let jsonDecoder: JSONDecoder

    // MARK: - Lifecycle

    init(
        networkRequestFactory: NetworkRequestFactoryProtocol = NetworkRequestFactory(),
        constants: RepositoriesConstantsProtocol = RepositoriesConstants(),
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkRequestFactory = networkRequestFactory
        self.constants = constants
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Public Functions

    func repositories(forName name: String, andPage page: Int?, andCountPerPage perPage: Int) {
        guard let url = URL(string: constants.repositories) else { return }
        let parameters = SearchParameters(q: name, page: page, per_page: perPage)
        Log.debug(parameters)
        do {
            request = try networkRequestFactory.get(url: url, parameters: parameters, resultHandler: self)
            request?.send()
        } catch {
            Log.error("repositories \(error)")
            resultHandler?.repositoriesRequestDidFailed(error)
        }
    }
    
    func cancelRequest() {
        
    }

    // MARK: - NetworkResultHandler Conformance

    func requestFailedWithResult(_ result: Data) {
        do {
            let repositoriesResponse = try jsonDecoder.decode(RepositoriesResponse.self, from: result)
            resultHandler?.repositoriesRequestDidSucceed(repositoriesResponse.items)
        } catch {
            Log.error("requestFailedWithResult \(error)")
            resultHandler?.repositoriesRequestDidFailed(error)
        }
    }

    func requestFailedWithError(_ error: Error) {
        Log.error("requestFailedWithError \(error)")
        resultHandler?.repositoriesRequestDidFailed(error)
    }
}
