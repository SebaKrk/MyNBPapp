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
    @ObservedObject private var cartViewModel = CartViewModel()
    
    // MARK: - Lifecycle
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.products, id: \.name) { product in
                        groupBoxItem(product)
                            .padding()
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    storeButton()
                        .padding()
                }
            }
        }
        .task {
            await viewModel.fetchStoreData()
        }
        .sheet(isPresented: $viewModel.showProductCardDetails) {
            if let selectedProduct = viewModel.selectedProduct {
                    ProductDetailView(selectedProduct)
                }
        }
        .sheet(isPresented: $viewModel.showCartView) {
            CartView(cardViewModel: cartViewModel)
        }
    }
    
    // MARK: - Subview
    
    private func groupBoxItem(_ item: PurchasableItem) -> some View {
        GroupBox {
            VStack {
                groupBoxHeader(item)
                    .background(.red)
                itemImage(item)
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
    
    private func itemImage(_ item: PurchasableItem) -> some View {
        Button {
            viewModel.selectProduct(item)
        } label: {
            // TODO: item.name -> download image
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .padding()
        }
    }
    
    private func priceLabel(_ price: Int) -> some View {
        Text("Już od \(price) zł")
    }
    
    private func addButton(_ item: PurchasableItem) -> some View {
        Button {
            cartViewModel.items.append(item)
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
            viewModel.handleCartButtonTapped(cartViewModel)
        } label: {
            if cartViewModel.items.isEmpty {
                Image(systemName: "basket")
                    .symbolEffect(.bounce.down.byLayer, options: .speed(0.8), value: viewModel.triggerEffect)
            } else {
                Text("\(cartViewModel.items.count)")
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background(.blue)
        .clipShape(Circle())
    }
        
    private var columns: [GridItem] {
        [ GridItem(.flexible()) ]
    }
    
}

