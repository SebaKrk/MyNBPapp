
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
    
    @ObservedObject var viewModel = FindPlaceViewModel()
    
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
                    //searchButton
                }
                .padding()
            }
            Spacer()
        }
   
        /// albo sheet overlay TF (sandBox)
        .overlay(alignment: .top) {
            searchTextFieldTop
        }
        .onSubmit(of: .text) {
            Task {
                await viewModel.findPlace(place: viewModel.search)
            }
        }
        /// zaprezentuj sheet z podglądem detali
        .sheet(isPresented: $viewModel.showDetails) {
            LocationDetailsView(mapSelection: $viewModel.mapSelection,
                                show: $viewModel.showDetails)
            .presentationDetents([.height(340)])
            .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
        }
        /// zaprezentuj listę wyszukanych miejsc
        .sheet(isPresented: $viewModel.showSearchResults) {
            SearchResultsListView(items: $viewModel.searchResults,
                                  title: viewModel.search,
                                  numberOfItem: viewModel.searchResultsCount)
                .presentationDetents([.height(150), .medium, .large])
                .presentationBackgroundInteraction(.enabled)
        }
    }
    
    // MARK: - ViewBuilders
    
    private var mapType: some View {
         let factory = DefaultMapViewsFactory()
         return factory.createMap(for: viewModel.isShowingSwiftUiMap ? .swiftUIMap : .uiKitMap)
        // .edgesIgnoringSafeArea(.all)
     }
    
    @ViewBuilder
    private func lookAroundView(scene: MKLookAroundScene?) -> some View {
        LookAroundPreview(scene: $viewModel.scene, badgePosition: .bottomTrailing)
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .safeAreaPadding(.bottom, 40)
            .padding(.horizontal, 20)
    }
    
    private var UnavailableView: some View {
        ContentUnavailableView("Brak podglądu", systemImage: "eye.slash")
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .safeAreaPadding(.bottom, 40)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var searchTextFieldTop: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for ...", text: $viewModel.search)
                .autocorrectionDisabled()
        }
        .padding(12)
        .background(.white)
        .cornerRadius(8)
        .foregroundColor(.primary)
        .padding()
        .shadow(radius: 20)
    }
    
    private var searchButton: some View {
        Button {
            viewModel.isSheetPresented.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
        }
        .opacity(viewModel.isSheetPresented ? 0 : 1)
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
    
    private var showsSearchResultsButton: some View {
        Button {
            viewModel.showSearchResults.toggle()
        } label: {
            Text("\(viewModel.searchResultsCount)")
        }
        .opacity(viewModel.isSheetPresented ? 0 : 1)
        .foregroundStyle(.white)
        .padding()
        .background(.blue.opacity(0.9))
        .clipShape(Circle())
    }
    
    private var mapTypeButton: some View {
        Button {
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
