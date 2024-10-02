//
//  CartViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    @Published var items: [PurchasableItem] = []
    
    func addToCart(_ item: PurchasableItem) {
        items.append(item)
    }
    
}
