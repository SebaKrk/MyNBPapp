//
//  PickerService.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Foundation
import DataModels

protocol PickerService {
    
    func fetchDataFormNBP(_ period: Period) async throws -> Exchange
    func getPeriod() -> Period
}
