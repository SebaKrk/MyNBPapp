//
//  SearchPlaceSheetView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 11/08/2024.
//

import SwiftUI
import MapKit

struct SearchPlaceSheetView: View {
    
    @State private var search: String = ""
    @Binding var items: [MKMapItem]
    
    var body: some View {
        VStack {
            searchTextField
            Spacer()
            resultList
        }
        .padding()
        .interactiveDismissDisabled()
        .presentationDetents([.height(150), .medium])
        .presentationBackground(.regularMaterial)
        .presentationBackgroundInteraction(.enabled(upThrough: .medium))
        .onChange(of: search) { oldValue, newValue in
            Task {
                await findPlace(place: newValue)
            }
        }
    }
    
    private var searchTextField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for a restaurant", text: $search)
                .autocorrectionDisabled()
        }
        .padding(12)
        .background(.gray.opacity(0.1))
        .cornerRadius(8)
        .foregroundColor(.primary)
//        .modifier(TextFieldGrayBackgroundColor())
    }
    
    private var resultList: some View {
        List(items, id: \.self) { item in
            VStack {
                HStack {
                    Text(item.name ?? "")
                        .font(.headline)
                    Text(item.phoneNumber ?? "brak")
                }
                if let postalAddress = item.placemark.postalAddress {
                    Text(postalAddress.street)
                }
                if let url = item.url {
                    Link(url.absoluteString, destination: url)
                        .lineLimit(1)
                        .foregroundStyle(.blue)
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    func findPlace(place: String) async ->  [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = place
        
        // request.region =  @State private var position = MapCameraPosition.automatic
        let search = MKLocalSearch(request: request)
        let response = try? await search.start()
        items = response?.mapItems ?? []
        //dump(items)
        return items
    }
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}
