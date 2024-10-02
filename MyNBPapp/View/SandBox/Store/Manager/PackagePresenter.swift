//
//  PackageManager.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 30/09/2024.
//

import Foundation

final class PackagePresenter: PurchasableItem {
    
    private let package: Package
    
    init(package: Package) {
        self.package = package
    }
    
    var name: String {
        return package.name
    }
    
    func display() -> String {
        let productNames = package.products.map { $0.name }.joined(separator: ", ")
        return "Package: \(package.name), Contains: \(productNames)"
    }
    
    func getPrice() -> Int {
        return package.products.reduce(0) { total, product in
            total + product.price
        }
    }
    
}
