//
//  APODServiceTests.swift
//  APODSwiftTests
//
//  Created by Khushboo Barve on 30/03/2025.
//

import XCTest
@testable import APODSwift

class APODServiceTests: XCTestCase {
    var service: APODService!

    override func setUp() {
        super.setUp()
        service = APODService()
        MockURLProtocol.requestHandler = nil
    }

    func test_fetchAPOD_successResponse() async throws {
        let mockDate = "2025-03-31"
        let jsonString = """
        {
            "date": "\(mockDate)",
            "explanation": "Some explanation text.",
            "url": "https://example.com/apod.jpg",
            "title": "Astronomy Picture of the Day"
        }
        """
        let jsonData = jsonString.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://api.nasa.gov/planetary/apod")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, jsonData)
        }
        let apod = try await service.fetchAPOD(for: mockDate)
        XCTAssertEqual(apod.date, mockDate)
        XCTAssertFalse(apod.title.isEmpty, "Title should not be empty")
        XCTAssertFalse(apod.explanation.isEmpty, "Explanation should not be empty")
        XCTAssertFalse(apod.url!.isEmpty, "URL should not be empty")
        XCTAssertTrue(apod.url!.starts(with: "http"), "URL should start with 'http' or 'https'")
    }


}
