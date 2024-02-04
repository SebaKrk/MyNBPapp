//
//  NBPService.swift
//
//
//  Created by Sebastian Sciuba on 01/02/2024.
//

import DataModels
import Foundation

public protocol NBPService {
    
    func getEuroData() async throws -> Exchange
    
}
