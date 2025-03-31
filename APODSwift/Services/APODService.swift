//
//  APODService.swift
//  APODSwift
//
//  Created by Khushboo Barve on 29/03/2025.
//

import Foundation

protocol APODServiceProtocol {
    func fetchAPOD(for date: String) async throws -> APODModel
}

class APODService: APODServiceProtocol {
    
    func fetchAPOD(for date: String) async throws -> APODModel {
        guard let url = APODService.buildQuery(date: date) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(APODModel.self, from: data)
    }
    
    static func buildQuery(date: String?) -> URL? {
        // Build the URL request
        var request = URLComponents()
        request.scheme = "https"
        request.host = "api.nasa.gov"
        request.path = "/planetary/apod"
        
        // Add API Key
        request.queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey)]
        
        // Add the date query parameter
        if let date = date {
            request.queryItems?.append(URLQueryItem(name: "date", value: date))
        }
        return request.url
    }
}
