//
//  ProductDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 06/10/2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductPresenter
    
    init(_ product: ProductPresenter) {
        self.product = product
    }
    
    var body: some View {
        
        GroupBox {
            VStack {
                productTitle
                productImage
                HStack {
                    Spacer()
                    productPrice
                }
            }
        }
        .padding()
    }
    
    private var productTitle: some View {
        Text(product.name)
            .bold()
    }
    
    private var productImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .cornerRadius(10)
            .shadow(radius: 4)
    }
    
    private var productPrice: some View {
        Text("Cena: \(product.getPrice())")
    }
    
}
