//
//  ChartType.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 24/03/2024.
//

import ComposableArchitecture
import Foundation

enum ChartType: Equatable, CaseIterable  {
    
    case lineMark
    case barMark
    
    var title: String {
        switch self {
        case .lineMark: return "Line Chart"
        case .barMark: return "Bar Chart"
        }
    }
}
