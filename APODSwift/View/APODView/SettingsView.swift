//
//  SettingsView.swift
//  APODSwift
//
//  Created by Khushboo Barve on 26/03/2025.
//

import SwiftUI

//*** Will be removed later when extnded feature added ***///
struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .padding()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
