//
//  CartViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/10/2024.
//

import Foundation

final class CartViewModel: ObservableObject {
    
    @Published var items: [CartItem] = []
    
    func addToCart(_ item: PurchasableItem) {
        if let index = items.firstIndex(where: { $0.item.id == item.id }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(item: item, quantity: 1)
            items.append(newItem)
        }
    }
    
    func totalPrice() -> Int {
        return items.reduce(0) { $0 + ($1.item.getPrice() * $1.quantity) }
    }
    
    func totalItems() -> Int {
        return items.reduce(0) { $0 + $1.quantity }
    }
    
}
