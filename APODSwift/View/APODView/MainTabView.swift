//
//  MainTabView.swift
//  APODSwift
//
//  Created by Khushboo Barve on 26/03/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            APODDetailView()
                .tabItem {
                    Label("APOD", systemImage: "photo")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
