//
//  PurchasableDetailView.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import SwiftUI

struct PurchasableDetailView: View {
    
    let item: PurchasableItem
    
    init(_ item: PurchasableItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let product = item as? ProductPresenter {
                ProductDetailView(product)
            }
            
            if let package = item as? PackagePresenter {
                PackageDetailView(package)
            }
        }
        .padding()
    }
    
}
