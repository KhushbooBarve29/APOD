//
//  APODView.swift
//  APODSwift
//
//  Created by Khushboo Barve on 26/03/2025.
//

import SwiftUI
import _AVKit_SwiftUI

struct APODDetailView: View {
    @StateObject var viewModel = APODViewModel()
    @State var showDatePicker = false
    @State private var showAlert = false
    @State private var errorMessage: String?
    
    let imageHeight: CGFloat =  0.4
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        // Change Date Button View
                        ChangeDateUI
                        
                        if viewModel.isLoading {
                            LoadingView()
                        }
                        if let apod = viewModel.apod {
                            Text(apod.title)
                                .font(.title2)
                            
                            if apod.mediaType == "image" {
                                AsyncImage(url: URL(string: apod.url!)) { image in
                                    image.resizable().scaledToFit()
                                } placeholder: {
                                    
                                    LoadingView()
                                }
                                .frame(height: geometry.size.height * imageHeight)
                            } else if apod.mediaType == "video" {
                                if apod.url!.contains("youtube.com") || apod.url!.contains("youtu.be") {
                                    WebView(url: URL(string: apod.url!)!)
                                        .frame(height: geometry.size.height * imageHeight)
                                } else if let videoURL = URL(string: apod.url!) {
                                    VideoPlayer(player: AVPlayer(url: videoURL))
                                        .frame(height: geometry.size.height * imageHeight)
                                } else {
                                    Text(viewModel.videoAlternate)
                                        .foregroundColor(.red)
                                }
                                
                            }
                            Text(apod.date).font(.title2)
                            Text(apod.explanation)
                                .padding()
                        }
                    }
                    .animation(.easeInOut, value: viewModel.apod)
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(viewModel.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(viewModel.alertErrorTitle),
                    message: Text(viewModel.alertErrorMessage),
                    dismissButton: .default(Text(viewModel.alertErrorButton))
                )
            }
            .onChange(of: viewModel.errorMessage) { newValue in
                if let error = newValue {
                    errorMessage = error
                    showAlert = true
                }
            }
        }
    }
}

struct APODDetailView_Previews: PreviewProvider {
    static var previews: some View {
        APODDetailView()
            .preferredColorScheme(.dark)
    }
}


