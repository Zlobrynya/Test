//
//  URLSession.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import Foundation

extension URLSession {
    /// Creates a data task.
    ///
    /// - Parameter request:  A URL request.
    /// - Parameter onResult: Called when the task succeeded.
    /// - Parameter onError: Called when the task failed.
    /// - Returns: `URLSessionDataTask`
    func dataTask(
        with request: URLRequest,
        onResult: @escaping (Data) -> Void,
        onError: @escaping (NetworkingError) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                onError(NetworkingError.error(error))
            } else if let data = data {
                let httpResponse = response as? HTTPURLResponse
                if
                    let httpResponse = httpResponse,
                    let statusCode = HTTPStatusCode(rawValue: httpResponse.statusCode),
                    statusCode.rawValue >= 400
                {
                    onError(NetworkingError.httpError(statusCode: statusCode))
                } else {
                    onResult(data)
                }
            } else {
                onError(NetworkingError.emptyResponse)
            }
        })
    }
}
