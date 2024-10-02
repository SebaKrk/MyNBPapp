//
//  PurchasableItem.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/09/2024.
//

import Foundation

protocol PurchasableItem {
    
    var name: String { get }
    func display() -> String
    func getPrice() -> Int
    
}
