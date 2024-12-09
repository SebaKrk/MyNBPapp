//
//  PeriodsPicker.swift
//  Commons
//
//  Created by Sebastian Sciuba on 09/12/2024.
//

import Foundation
import DataModels

public enum PeriodsPicker: String, Equatable {
    
    case current
    case previous
    
    public var title: String {
        switch self {
        case .current: return "Current"
        case .previous: return "Previous"
        }
    }
}
