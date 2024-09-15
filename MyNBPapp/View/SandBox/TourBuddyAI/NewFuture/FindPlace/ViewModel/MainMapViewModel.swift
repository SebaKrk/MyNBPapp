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
    
    var activeViewModel: any MapViewModelProtocol {
        isShowingSwiftUiMap ? swiftUIMapViewModel : uiKitMapViewModel
    }
    
    @MainActor
    func performSearch() async {
        if let viewModel = activeViewModel as? SwiftUIMapViewModel {
            await viewModel.findPlace(for: searchText)
            self.searchResults = viewModel.searchResults
        } else if let viewModel = activeViewModel as? UIKitMapViewModel {
            await viewModel.findPlace(for: searchText)
            self.searchResults = viewModel.searchResults
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
