//
//  CartItem.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 07/10/2024.
//

import Foundation

struct CartItem {
    let item: PurchasableItem
    var quantity: Int
    
    var id: String {
        return item.id
    }
}
