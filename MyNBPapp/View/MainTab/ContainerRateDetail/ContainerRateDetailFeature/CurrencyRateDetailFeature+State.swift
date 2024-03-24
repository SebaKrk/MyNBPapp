//
// ContainerRateDetailFeature+State.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 18/03/2024.
//

import ComposableArchitecture
import DataModels
import Foundation

/// `ContainerRateDetail+State`
extension ContainerRateDetailFeature {
    
    @ObservableState
    struct State: Equatable {
        var exchange: Exchange?
        
        var chartType: ChartType = .lineMark
    }
    
}
