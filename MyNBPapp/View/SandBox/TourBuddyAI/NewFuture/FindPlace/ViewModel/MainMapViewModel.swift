//
//  MainMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import SwiftUI
import MapKit

class MainMapViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var searchResults: [MKMapItem] = []
    
    @Published var swiftUIMapViewModel = SwiftUIMapViewModel()
    @Published var uiKitMapViewModel = UIKitMapViewModel()
    
    @Published var isShowingSwiftUiMap = true
    @Published var showSearchResults: Bool = false
    @Published var currentError: SearchError?
    
    var activeViewModel: any MapViewModelProtocol {
        isShowingSwiftUiMap ? swiftUIMapViewModel : uiKitMapViewModel
    }
    
    @MainActor
    func performSearch() async {
        do {
            if let viewModel = activeViewModel as? SwiftUIMapViewModel {
                try await viewModel.findPlace(for: searchText)
                self.searchResults = viewModel.searchResults
            } else if let viewModel = activeViewModel as? UIKitMapViewModel {
                try await viewModel.findPlace(for: searchText)
                self.searchResults = viewModel.searchResults
            }
        } catch let error as SearchError {
            self.currentError = error
        } catch {
            self.currentError = .unknownError
            print("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    func clearSearchResults() {
        self.searchResults = []
        if isShowingSwiftUiMap {
            swiftUIMapViewModel.searchResults = []
        } else {
            uiKitMapViewModel.searchResults = []
        }
    }
    
}
