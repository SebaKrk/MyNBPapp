//
//  PickerRepository.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Foundation
import DataModels

public protocol PickerRepository {
    
    func fetchDataFormNBP(period: Period) async throws -> Exchange 
    
}
