//
//  ViewController.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 27.01.2021.
//

import UIKit

class ViewController: UIViewController, NetworkResultHandler {

    private var request: RequestProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let net = NetworkFactory()
        guard let url = URL(string: "https://api.github.com/search/repositories") else { return }
        let search = SearchParameters(q: "test")
        do {
            request = try net.get(url: url, parameters: search, resultHandler: self)
            request?.send()
        } catch {
            debugPrint(error)
        }
        debugPrint(search.asDictionary)
    }
    
    func requestFailedWithResult(_ data: Data) {
        debugPrint(data)
    }
    
    func requestFailedWithError(_ error: NetworkingError) {
        print("||")
        debugPrint(error)
    }
}
