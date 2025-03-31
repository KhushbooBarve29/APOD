//
//  APODModel.swift
//  APODSwift
//
//  Created by Khushboo Barve on 25/03/2025.
//

import Foundation

struct APODModel: Codable, Identifiable, Equatable {
    let id = UUID()
    let title: String
    let date: String
    let explanation: String
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
    }
}
