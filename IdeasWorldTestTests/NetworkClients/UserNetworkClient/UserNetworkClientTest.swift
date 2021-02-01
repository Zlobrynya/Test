//
//  UserNetworkClientTest.swift
//  IdeasWorldTestTests
//
//  Created by Nikitin Nikita on 01.02.2021.
//

@testable import IdeasWorldTest
import XCTest

// swiftlint:disable force_unwrapping
class UserNetworkClientTest: XCTestCase {

    // MARK: - SUT

    var sut: UserNetworkClient!

    // MARK: - Dependencies

    private var mockResultHandler: MockUserNetworkClientResultHandler!
    private var mockNetworkClient: MockNetworkRequestFactory!
    private let constants = UserConstants()
    private let jsonDecoder = JSONDecoder()

    // MARK: - Constants

    private let user = User(id: 1, name: "namne", email: "email")

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        mockResultHandler = MockUserNetworkClientResultHandler()
        mockNetworkClient = MockNetworkRequestFactory()
        sut = UserNetworkClient(
            networkRequestFactory: mockNetworkClient,
            constants: constants,
            jsonDecoder: jsonDecoder
        )
        sut.resultHandler = mockResultHandler
    }

    override func tearDown() {
        mockResultHandler = nil
        mockNetworkClient = nil
        sut = nil
        super.tearDown()
    }

    // MARK: - Test Functions

    func test_user_requestDidSend() {

        // WHEN

        sut.user(forUsername: user.name)

        // THEN

        let mockUrl = URL(string: constants.userEndpoint(user.name))

        XCTAssertNil(mockResultHandler.error)
        XCTAssertEqual(mockUrl, mockNetworkClient.url)
        XCTAssertTrue(mockNetworkClient.request!.didCallSend)
    }

    func test_user_throwError_requestDidNotSend() {
        // GIVEN

        mockNetworkClient.shouldThrowError = true

        // WHEN

        sut.user(forUsername: user.name)

        // THEN

        let mockUrl = URL(string: constants.userEndpoint(user.name))

        XCTAssertEqual(mockResultHandler.error as? NetworkingError, .emptyResponse)
        XCTAssertEqual(mockUrl, mockNetworkClient.url)
        XCTAssertNil(mockNetworkClient.request)
    }

    func test_requestFailedWithResult_withData_dataWasDecodedCorrectly() throws {
        // GIVEN

        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "UserJson", withExtension: "json") else {
            XCTFail("Missing file json")
            return
        }

        let data = try Data(contentsOf: url)

        // WHEN

        sut.requestFailedWithResult(data)

        // THEN

        let mockUser = try jsonDecoder.decode(User.self, from: data)

        XCTAssertEqual(mockUser.id, mockResultHandler.user!.id)
    }

    func test_requestFailedWithResult_withoutData_dataWasNotDecodedCorrectly() {
        // GIVEN

        let data = Data()

        // WHEN

        sut.requestFailedWithResult(data)

        // THEN

        XCTAssertNotNil(mockResultHandler.error)
    }

    func test_requestFailedWithError_errorWasPassedSuccessfully() {
        // WHEN

        sut.requestFailedWithError(NetworkingError.emptyResponse)

        // THEN

        XCTAssertEqual(mockResultHandler.error! as? NetworkingError, .emptyResponse)
    }
}
