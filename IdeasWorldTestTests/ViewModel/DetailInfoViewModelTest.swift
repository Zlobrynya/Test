//
//  DetailInfoViewModelTest.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

@testable import IdeasWorldTest
import XCTest

// swiftlint:disable force_unwrapping
class DetailInfoViewModelTest: XCTestCase {
    // MARK: - SUT

    var sut: DetailInfoViewModel!

    // MARK: - Dependencies

    var mockUserNetworkClient: MockUserNetworkClient!
    var mockRepositoryCoreData: MockRepositoryCoreData!

    // MARK: - Constants

    let repository = Repository(id: 99, name: "TestName", username: "TestUserName")

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockUserNetworkClient = MockUserNetworkClient()
        mockRepositoryCoreData = MockRepositoryCoreData()
        sut = DetailInfoViewModel(
            repository: repository,
            networkClient: mockUserNetworkClient,
            repositoryCoreData: mockRepositoryCoreData
        )
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Test Functions

    func test_onAppear_hasRepository_networkWasCalledAndFavouriteWasSetCorrectly() {
        // GIVEN

        mockRepositoryCoreData.hasRepository = true

        // WHEN

        sut.onAppear()

        // THEN

        XCTAssertTrue(sut.isFavorite)
        XCTAssertEqual(mockUserNetworkClient.username, repository.username)
    }

    func test_onAppear_hasNotRepository_networkWasCalledAndFavouriteWasSetCorrectly() {
        // GIVEN

        mockRepositoryCoreData.hasRepository = false

        // WHEN

        sut.onAppear()

        // THEN

        XCTAssertFalse(sut.isFavorite)
        XCTAssertEqual(mockUserNetworkClient.username, repository.username)
    }

    func test_favourite_isFavoriteIsFalse_repositoryCoreDataStoreWasCalled() {
        // GIVEN

        sut.isFavorite = false

        // WHEN

        sut.favourite()

        // THEN

        XCTAssertTrue(mockRepositoryCoreData.didCallStore)
        XCTAssertEqual(mockRepositoryCoreData.storeRepository!.id, repository.id)
    }

    func test_favourite_isFavoriteIsTrue_repositoryCoreDataStoreWasCalled() {
        // GIVEN

        sut.isFavorite = true

        // WHEN

        sut.favourite()

        // THEN

        XCTAssertTrue(mockRepositoryCoreData.didCallRemove)
    }
}
