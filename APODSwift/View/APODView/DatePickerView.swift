//
//  DatePickerView.swift
//  APODSwift
//
//  Created by Khushboo Barve on 26/03/2025.
//

import SwiftUI

struct DatePickerView: View {
    @ObservedObject var viewModel: APODViewModel
    @Environment(\.presentationMode) var presentation
    
    let datPickerWidth: CGFloat = 160
    let datPickerHeight: CGFloat = 50
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker("", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .font(.largeTitle)
                    .padding(.bottom, 50)
                Button(viewModel.DoneButton) {
                    Task {
                        await viewModel.fetchAPOD(for: viewModel.selectedDate)
                    }
                    presentation.wrappedValue.dismiss()
                }
                .font(.title2)
                .frame(width: datPickerWidth, height: datPickerHeight, alignment: .center)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .accessibilityLabel("Next APOD")
                .accessibilityHint("Loads the next Astronomy Picture of the Day")
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pick Your Date")
                        .font(.title)
                }
            }
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(viewModel: APODViewModel())
            .preferredColorScheme(.dark)
    }
}

