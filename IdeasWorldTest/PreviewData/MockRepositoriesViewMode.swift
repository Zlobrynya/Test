//
//  MockRepositoriesViewMode.swift
//  IdeasWorldTest
//
//  Created by Nikitin Nikita on 29.01.2021.
//

import Foundation

class MockRepositoriesViewMode: RepositoriesViewModel {

    init() {
        super.init()
        
        Log.debug(Bundle.main.path(forResource: "RepositoriesJson", ofType: "json"))
                
        guard
            let path = Bundle.main.path(forResource: "RepositoriesJson", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let repositoriesResponse = try? JSONDecoder().decode(RepositoriesResponse.self, from: data)
        else {
            return
        }

        repositories = repositoriesResponse.items
    }
}
