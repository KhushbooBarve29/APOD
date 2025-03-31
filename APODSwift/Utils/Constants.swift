//
//  Constants.swift
//  APODSwift
//
//  Created by Khushboo Barve on 25/03/2025.
//

import Foundation

struct Constants {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    static let cacheKey = Bundle.main.object(forInfoDictionaryKey: "CACHE_KEY") as? String ?? ""
}
