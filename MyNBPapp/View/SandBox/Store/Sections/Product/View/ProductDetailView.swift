//
//  ProductDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    let item: PurchasableItem
    
    init(_ item: PurchasableItem) {
        self.item = item
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
            if let product = item as? ProductPresenter {
                Text(product.image)
            }

            if let package = item as? PackagePresenter {
                Text(package.display())
                ForEach(package.products) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text("\(product.price) pln")
                    }
                }
            }
            
            Text("Cena: \(item.getPrice()) pln")
        }
        .padding()
    }
}
