//
//  RepositoriesNetworkClient.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 28.01.2021.
//

import Foundation

protocol RepositoriesNetworkClientResultHandler: AnyObject {
    
    /// Called when repositories are received successfully.
    ///
    /// - Parameter repositories: An array of repositories received from the the server.
    func repositoriesRequestDidSucceed(_ repositories: [RepositoryProtocol])

    /// Called when fetching the repositories failed.
    ///
    /// - Parameter error: Any error that occurred when trying to get repositories.
    func repositoriesRequestDidFailed(_ error: Error)
}

protocol RepositoriesNetworkClientProtocol: NetworkResultHandler {
    /// Fetches repositories from the server.
    ///
    /// - Parameter name: Repository name
    /// - Parameter page: Page of request
    /// - Parameter perPage: Number of repositories per page
    func repositories(forName name: String, andPage page: Int?, andCountPerPage perPage: Int)

    ///  Canceling the request
    func cancelRequest()

    /// The object that acts as the result handler for fetching repositories.
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

    func cancelRequest() {}

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
