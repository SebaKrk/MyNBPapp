//
//  ContainerRateDetail+Action.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 18/03/2024.
//

import ComposableArchitecture
import Foundation

/// `ContainerRateDetail+Action`
extension ContainerRateDetailFeature {
    
    @CasePathable
    enum Action {
        
        case changeChartType(ChartType)
    }
    
}
