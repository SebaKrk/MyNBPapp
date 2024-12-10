//
//  Periods.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Foundation
import DataModels

public enum PeriodsState: Hashable, Equatable {
    
    /// Current period
    case currentPeriod(Period)
    
    /// Previous period
    case previousPeriod(Period)
    
    case none
        
}
