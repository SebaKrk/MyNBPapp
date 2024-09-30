//
//  ProductManager.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/09/2024.
//

import Foundation

final class ProductPresenter: PurchasableItem {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var name: String {
        return product.name
    }
    
    func display() -> String {
        return "Product: \(product.name), Price: \(product.price)"
    }
    
    func getPrice() -> Int {
        return product.price
    }
    
}
