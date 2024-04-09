//
//  TableNBP.swift
//  
//
//  Created by Sebastian Sciuba on 14/03/2024.
//

import Foundation

public enum TableNBP: String, Equatable, CaseIterable  {
    
    case a = "a"
    case c = "c"
    
    var type: String {
        switch self {
        case .a: return "a"
        case .c: return "c"
        }
    }
    
    public var title: String {
        switch self {
        case .a: return "Kurs Walut"
        case .c: return "Kupno/Sprzedaż"
        }
    }
}
