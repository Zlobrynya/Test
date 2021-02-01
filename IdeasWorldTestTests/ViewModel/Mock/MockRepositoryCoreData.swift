//
//  MockRepositoryCoreData.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

@testable import IdeasWorldTest
import Foundation

class MockRepositoryCoreData: RepositoryCoreDataProtocol {
    
    // MARK: - Public Properties
    
    var didCallStore = false
    var didCallRepository = false
    var didCallRemove = false
    var didCallHasRepository = false
    
    var hasRepository = false
    var storeRepository: RepositoryProtocol?

    // MARK: - Public Functions
    
    func store(_ repository: RepositoryProtocol) {
        didCallStore = true
        storeRepository = repository
    }
    
    func repository() -> [RepositoryProtocol] {
        [Repository(id: 1, name: "name", username: "username")]
    }
    
    func repository(byId id: Int) -> RepositoryProtocol? {
        didCallRepository = true
        return Repository(id: 1, name: "name", username: "username")
    }
    
    func remove(byId id: Int) {
        didCallRemove = true
    }
    
    func hasRepository(byId id: Int) -> Bool {
        didCallHasRepository = true
        return hasRepository
    }
}
