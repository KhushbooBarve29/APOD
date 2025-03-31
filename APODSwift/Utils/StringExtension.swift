//
//  StringExtension.swift
//  APODSwift
//
//  Created by Khushboo Barve on 29/03/2025.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(args: [CVarArg]) -> String {
        String(format: self.localized, locale: nil, arguments: args)
    }
}
