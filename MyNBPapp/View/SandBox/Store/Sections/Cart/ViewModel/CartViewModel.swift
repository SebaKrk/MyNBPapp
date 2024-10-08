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
    
    func totalProductsInPackage(for packageId: String) -> Int {
          if let cartItem = items.first(where: { $0.item.id == packageId }),
             let package = cartItem.item as? PackagePresenter {
              return package.products.count * cartItem.quantity
          }
          return 0
      }
    
    func totalItems() -> Int {
        return items.reduce(0) { total, cartItem in
            if let package = cartItem.item as? PackagePresenter {
                return total + (package.products.count * cartItem.quantity)
            } else {
                return total + cartItem.quantity
            }
        }
    }
    
}
