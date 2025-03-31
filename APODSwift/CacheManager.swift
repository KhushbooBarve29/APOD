//
//  CacheManager.swift
//  APODSwift
//
//  Created by Khushboo Barve on 25/03/2025.
//

import Foundation

class CacheManager {
    static func loadLastFetchedAPOD() -> APODModel? {
        if let data = UserDefaults.standard.data(forKey: Constants.cacheKey) {
            let decoder = JSONDecoder()
            if let apod = try? decoder.decode(APODModel.self, from: data) {
                return apod
            }
        }
        return nil
    }
    
    static func cacheAPOD(_ apod: APODModel) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(apod) {
            UserDefaults.standard.set(data, forKey: Constants.cacheKey)
        }
    }
}
