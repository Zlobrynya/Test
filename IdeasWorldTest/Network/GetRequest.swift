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
    func send()
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
    }

    // MARK: - Public Properties

    func send() {
        task = urlSession.dataTask(
            with: request,
            onResult: { [weak self] in
                self?.resultHandler?.requestDidSuccessful($0)
            },
            onError: { [weak self] in
                self?.resultHandler?.requestDidFailed($0)
            }
        )
        task?.resume()
    }
}
