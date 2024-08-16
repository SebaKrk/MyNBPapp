//
//  FindPlaceViewWithSearchable.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 16/08/2024.
//

import SwiftUI
import MapKit

@available(iOS 18.0, *)
struct FindPlaceViewWithSearchable: View {
    
    @ObservedObject var viewModel = FindPlaceViewModel()
    
    var body: some View {
        NavigationStack {
            Map(position: $viewModel.position) {
                UserAnnotation()
                if !viewModel.searchResults.isEmpty {
                    ForEach(viewModel.searchResults, id: \.self) { item in
                        Marker(item: item)
                            .tag(MapSelection(item))
                    }
                }
            }
        }
        .onChange(of: viewModel.searchResults) { oldValue, newValue in
            if let item = newValue.first {
                viewModel.centerMapOnItem(item)
            }
        }
        .onSubmit(of: .search) {
            print(viewModel.search)
            Task {
                await viewModel.findPlace(place: viewModel.search)
            }
        }
        .searchable(text: $viewModel.search, placement: .sidebar, prompt: "Znajdź miejsce...")
    } // nie dziala
}

struct TestWithSearchable: View {
    @State private var searchText = ""

    let items = ["Apple", "Banana", "Orange", "Grapes", "Pineapple"]

    var filteredItems: [String] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.contains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            List(filteredItems, id: \.self) { item in
                Text(item)
            }
            .navigationTitle("Fruits")
            .searchable(text: $searchText)
        }
    }
}

