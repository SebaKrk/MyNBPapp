//
//  ProductsService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

protocol ProductsService {
    
    func fetchProducts(from json: String) async throws -> [Product] 
    
}
