//
//  APODViewModel.swift
//  APODSwift
//
//  Created by Khushboo Barve on 25/03/2025.
//

import Foundation

class APODViewModel: ObservableObject {
    @Published var apod: APODModel?
    @Published var errorMessage: String?
    @Published var selectedDate: Date = Date()
    @Published var isLoading: Bool = false
    
    private let service: APODServiceProtocol
    
    /// APOD Detail View
    let title: String = "ui.apod.title".localized
    let alertErrorTitle: String = "ui.apod.error.alert.title".localized
    let alertErrorMessage: String = "ui.apod.error.alert.message".localized
    let alertErrorButton: String = "ui.apod.error.alert.button".localized
    let changeDateButton: String = "ui.apod.button".localized
    let videoAlternate: String = "ui.apod.video.not.supported".localized
    
    /// Tab Bar View
    let tabBar: String = "ui.apod.tab.bar".localized
    let tabBarSetting: String = "ui.apod.tab.bar.setting".localized
    
    /// Date Picker View
    let DatePickerTitle: String = "ui.apod.date.picker.title".localized
    let DoneButton: String = "ui.apod.date.picker.done.button".localized
    
    init(service: APODServiceProtocol = APODService()) {
        self.service = service
        Task {
            await fetchAPOD(for: Date())
        }
    }
    
    func fetchAPOD(for date: Date) async {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let apod = try await service.fetchAPOD(for: dateString)
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                if apod.mediaType == "image" || apod.mediaType == "video" {
                    self.apod = apod
                    CacheManager.cacheAPOD(apod)
                } else {
                    self.apod = APODModel(
                        title: apod.title, date: apod.date, explanation: apod.explanation, hdurl: apod.hdurl, mediaType: apod.mediaType, serviceVersion: nil, url: apod.url
                    )
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                if let cachedAPOD = CacheManager.loadLastFetchedAPOD() {
                    self.apod = cachedAPOD
                } else {
                    self.apod = nil
                }
                
                if let APIError = error as? APIError {
                    self.errorMessage = APIError.description()
                } else {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
