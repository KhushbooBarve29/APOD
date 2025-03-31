//
//  APODServiceMock.swift Original original
//  APODSwift
//
//  Created by Khushboo Barve on 29/03/2025.
//

import Foundation

enum APIError: Error {
    case noError
    case badParams
    case badResponse
    case noData
    case cantDecode
    
    func description() -> String {
        switch self {
        case .noError: return "No Error"
        case .badParams: return "Can't make a valid URL using the supplied parameters"
        case .badResponse: return "Server returned an error"
        case .noData: return "No data returned by APOD API"
        case .cantDecode: return "Not Decodable (JSON couldn't be parsed)"
        }
    }
}

class APODServiceMock: APODServiceProtocol {
    var mockAPOD: APODModel?
    var APIError: Error?

    func fetchAPOD(for date: String) async throws -> APODModel {
        if let error = APIError {
            throw error
        }
        guard let apod = mockAPOD else {
            throw URLError(.badServerResponse)
        }
        return apod
    }
}
