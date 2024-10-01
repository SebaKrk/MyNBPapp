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
    
    // MARK: - Lifecycle
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.products, id: \.name) { product in
                    groupBoxItem(product)
                        .padding()
                }
            }
        }
        .task {
            await viewModel.fetchStoreData()
        }
        .sheet(isPresented: $viewModel.showProductCardDetails) {
            if let selectedProduct = viewModel.selectedProduct {
                    ProductDetailView(product: selectedProduct)
                }
        }
    }
    
    // MARK: - Subview
    
    private func groupBoxItem(_ item: PurchasableItem) -> some View {
        GroupBox {
            VStack {
                groupBoxHeader(item)
                    .background(.red)
                itemImage("photo")
                    .background(.yellow)
                groupBoxBottom(item)
                    .background(.green)
            }
            
        }
        //.groupBoxStyle(ContainerBoxStyle(color: .white))
        .frame(maxWidth: .infinity, maxHeight: 400)
        .padding()
    }
    
    private func groupBoxHeader(_ item: PurchasableItem) -> some View {
        HStack {
            headerTitle(item.name)
            Spacer()
        }
        .frame(height: 75)
    }
    
    
    private func groupBoxBottom (_ item: PurchasableItem) -> some View {
        HStack {
            priceLabel(item.getPrice())
            Spacer()
            addButton(item)
        }
        .frame(height: 50)
    }
    
    private func headerTitle(_ title: String) -> some View {
        Text(title)
            .frame(height: 50)
    }
    
    private func itemImage(_ name: String) -> some View {
        Image(systemName: name)
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .padding()
    }
    
    private func priceLabel(_ price: Int) -> some View {
        Text("Już od \(price) zł")
    }
    
    private func addButton(_ item: PurchasableItem) -> some View {
        Button {
            viewModel.selectProduct(item)
        } label: {
            Text("Kup")
                .padding(6)
                .foregroundStyle(.white)
                .background(.blue)
                .clipShape(Capsule())
        }
    }
    
    private func storeButton() -> some View {
        Button {
            
        } label: {
            if viewModel.items.isEmpty {
                Image(systemName: "basket")
            } else {
                Text("\(viewModel.items.count)")
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(.blue).opacity(0.7)
        .clipShape(Circle())
    }
        
    private var columns: [GridItem] {
        [ GridItem(.flexible()) ]
    }
}

struct ProductDetailView: View {
    let product: PurchasableItem

    var body: some View {
            Text(product.name)
    }
}
