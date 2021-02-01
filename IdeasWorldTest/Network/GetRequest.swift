//
//  GetRequest.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

enum TypeRequest: String {
    case get = "GET"
}

enum ErrorRequest: LocalizedError {
    case non
}

protocol RequestProtocol {
    ///  Sending a request.
    func send()
    
    /// Canceling a request.
    func cancel()
}

class GetRequest: RequestProtocol {

    // MARK: - Private Properties

    private var request: URLRequest
    private var task: URLSessionDataTask?

    // MARK: - External Dependencies

    private let urlSession: URLSession
    private weak var resultHandler: NetworkResultHandler?

    // MARK: - Lifecycle

    init<T: ParametersProtocol>(
        url: URL,
        parameters: T,
        resultHandler: NetworkResultHandler?,
        jsonEncoder: JSONEncoder = JSONEncoder(),
        networkConstants: NetworkConstantsProtocol = NetworkConstants(),
        urlSession: URLSession = URLSession.shared
    ) throws {
        self.urlSession = urlSession
        self.resultHandler = resultHandler

        if !(parameters is EmptyParameters) {
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
            else { throw ErrorRequest.non }
            urlComponents.queryItems = parameters.asDictionary.asURLQueryItem()
            guard let url = urlComponents.url else { throw ErrorRequest.non }
            request = URLRequest(url: url)
        } else {
            request = URLRequest(url: url)
        }
        request.httpMethod = TypeRequest.get.rawValue
        request.allHTTPHeaderFields?[networkConstants.authorizationHeader] = networkConstants.token
    }

    // MARK: - Public Properties

    func send() {
        let resultHandler = self.resultHandler
        task = urlSession.dataTask(
            with: request,
            onResult: { resultHandler?.requestFailedWithResult($0) },
            onError: { resultHandler?.requestFailedWithError($0) }
        )
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}
