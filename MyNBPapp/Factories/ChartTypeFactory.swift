//
//  ChartTypeFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 09/04/2024.
//

import SwiftUI

protocol ChartTypeFactory {
    
    associatedtype Content: View
    
    func createChartView(_ viewModel: CurrencyRateDetailViewModel) -> Content
    
}
