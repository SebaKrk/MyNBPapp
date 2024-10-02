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
            Text("Cena: \(item.getPrice()) zł")
        }
        .padding()
    }
}

//if let package = item as? Package {
//    Text("Produkty w pakiecie:")
//    ForEach(package.products, id: \.id) { product in
//        Text("- \(product.name), Cena: \(product.price) zł")
//    }
//    Text("Łączna cena: \(package.getPrice()) zł")
//}
