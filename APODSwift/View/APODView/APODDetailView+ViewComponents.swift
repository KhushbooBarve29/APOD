//
//  APODDetailView+ViewComponents.swift
//  APODSwift
//
//  Created by Khushboo Barve on 29/03/2025.
//

import SwiftUI

extension APODDetailView {
    /* Title Label - View */
    @ViewBuilder
    var ChangeDateUI: some View {
        HStack {
            Button(action: {
                showDatePicker = true
            }) {
                Image(systemName: "calendar")
                Text(viewModel.changeDateButton)
            }
            .accessibilityLabel("Pick next APOD")
            .accessibilityHint("Pick the next Astronomy Picture of the Day")
            .padding(.trailing)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .sheet(isPresented: $showDatePicker) {
                DatePickerView(viewModel: viewModel)
            }
        }
        
    }
    
}
