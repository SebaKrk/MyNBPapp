//
//  StatisticTitle.swift
//
//
//  Created by Sebastian Sciuba on 03/02/2024.
//

import Foundation

public enum StatisticTitle: Codable, Hashable, Identifiable, CaseIterable {

    case current
    case highest
    case lowest
    case yesterday
    case lastDay
    case last30Day
    
    public var id: StatisticTitle {self}
    
    public var title: String {
        switch self {
        case .current: return "Current exchange rate"
        case .highest: return "The highest rate"
        case .lowest: return "The lowest rate"
        case .yesterday: return "Yesterday"
        case .lastDay: return "Last day"
        case .last30Day: return "Last 30 day"
        }
    }
    
}
