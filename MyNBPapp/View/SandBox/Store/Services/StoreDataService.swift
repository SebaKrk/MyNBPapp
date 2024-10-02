//
//  StoreDataService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 29/09/2024.
//

import Foundation

protocol StoreDataService {
    
    func fetchStoreData(from json: String) async throws -> AppleStoreData
    
}
