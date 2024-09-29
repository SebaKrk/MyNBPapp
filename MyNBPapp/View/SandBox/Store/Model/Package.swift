//
//  Package.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

struct Package: Codable, Identifiable {
    let id: String
    let name: String
    let products: [Product]
}

struct PackageItem: Codable {
    let productId: String?
    let packageId: String?  
}
