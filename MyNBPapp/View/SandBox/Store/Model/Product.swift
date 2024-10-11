//
//  Product.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

struct Product: Codable, Identifiable {

    let id: String
    let name: String
    let price: Int
    let image: String
    
}
