
//
//  FindPlaceView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
struct FindPlaceView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = MainMapViewModel()
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                mapType
                HStack {
                    if !viewModel.searchResults.isEmpty {
                        showsSearchResultsButton
                    }
                    Spacer()
                    mapTypeButton
                }
                .padding()
            }
            Spacer()
        }
        .overlay(alignment: .top) {
            searchTextFieldTop
        }
        /// zaprezentuj listę wyszukanych miejsc
        .sheet(isPresented: $viewModel.showSearchResults) {
            searchResultSheet
        }
    }
    
    // MARK: - SubView
    
    private var searchTextFieldTop: some View {
        MapSearchTextField(searchText: $viewModel.searchText)
            .onSubmit {
                Task {
                    await viewModel.performSearch()
                }
            }
    }
    
    private var searchResultSheet: some View {
        SearchResultsListView(items: $viewModel.searchResults,
                              title: viewModel.searchText,
                              numberOfItem: viewModel.searchResults.count)
            .presentationDetents([.height(150), .medium, .large])
            .presentationBackgroundInteraction(.enabled)
    }
    
    private var mapType: some View {
        let factory = DefaultMapViewsFactory()
        if viewModel.isShowingSwiftUiMap {
            return factory.createMap(for: .swiftUIMap, viewModel: viewModel.swiftUIMapViewModel)
        } else {
            return factory.createMap(for: .uiKitMap, viewModel: viewModel.uiKitMapViewModel)
        }
        ///return factory.createMap(for: viewModel.isShowingSwiftUiMap ? .swiftUIMap : .uiKitMap, viewModel: viewModel.activeViewModel)
    }
    
    private var showsSearchResultsButton: some View {
        Button {
             viewModel.showSearchResults.toggle()
        } label: {
            Text("\(viewModel.searchResults.count)")
        }
         .opacity(viewModel.showSearchResults ? 0 : 1)
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
    
    private var mapTypeButton: some View {
        Button {
            viewModel.clearSearchResults()
            viewModel.isShowingSwiftUiMap.toggle()
        } label: {
            Image(systemName: "swift")
        }
        .foregroundStyle(viewModel.isShowingSwiftUiMap ? .black : .white)
        .padding()
        .background(viewModel.isShowingSwiftUiMap ? .blue : .orange).opacity(0.7)
        .clipShape(Circle())
    }
}
