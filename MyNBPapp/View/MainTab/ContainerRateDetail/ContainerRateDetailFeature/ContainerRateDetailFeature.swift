//
//  ContainerRateDetailFeature.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 17/03/2024.
//

import ComposableArchitecture
import Foundation

/// `ContainerRateDetail+Reducer`
@Reducer
struct ContainerRateDetailFeature {
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            
            case let .changeChartType(chartType):
                state.chartType = chartType
                return .none
            }
            
        }
    }
    
}
