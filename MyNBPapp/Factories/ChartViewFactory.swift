//
//  ChartViewFactory.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import Foundation
import DataModels
import SwiftUI

protocol ChartViewFactory {
    
    associatedtype Content: View
    
    func createCurrencyDetailsViews(chart type: ChartType,
                                    exchange: Exchange) -> Content
}
