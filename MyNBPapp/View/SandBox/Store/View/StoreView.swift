//
//  StoreView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import SwiftUI

struct StoreView: View {
    
    // MARK: -  Properties
    
    @ObservedObject private var viewModel: StoreViewModel = StoreViewModel()
    
    // test
    @State var items: [PurchasableItem] = []
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.products, id: \.name) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        addButton(product)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchStoreData()
        }
        
    }
    
    // MARK: - Subview
    
    private func addButton(_ item: PurchasableItem) -> some View {
        Button {
            items.append(item)
        } label: {
            Text("add")
        }
        
    }
        
    private var columns: [GridItem] {
        [ GridItem(.flexible()) ]
    }
}
