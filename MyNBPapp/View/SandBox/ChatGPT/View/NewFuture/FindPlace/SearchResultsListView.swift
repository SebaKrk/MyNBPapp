//
//  SearchResultsListView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/08/2024.
//

import SwiftUI
import MapKit

struct SearchResultsListView: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @Binding var items: [MKMapItem]
    
    @State private var singleSelection: MKMapItem?
    @State private var showDetails: Bool = false

    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                EditButton()
            }
            Spacer()
            List {
                ForEach(items, id: \.self) { item in
                    Button {
                        singleSelection = item
                        dump("seba \(item)")
                        showDetails = true
                    } label: {
                        cell(item.name ?? "brak")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .sheet(isPresented: $showDetails) {
                DetailsView(detailsItem: $singleSelection)
            }
        }
    }
    
    // MARK: SubView
    
    private func cell(_ item: String) -> some View {
        Text(item)
    }
    
    private func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
}

struct DetailsView: View {
    
    @Binding var detailsItem: MKMapItem?
    
    var body: some View {
        if let item = detailsItem {
            Text(item.name ?? "Brak nazwy") //.name ?? "")
        }
    }
    
}
