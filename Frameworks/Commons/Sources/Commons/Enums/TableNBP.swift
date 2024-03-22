//
//  TableNBP.swift
//  
//
//  Created by Sebastian Sciuba on 14/03/2024.
//

import Foundation

public enum TableNBP: String {
    
    case a = "a"
    case b = "b"
    case c = "c"
    
    var type: String {
        switch self {
        case .a: return "a"
        case .b: return "b"
        case .c: return "c"
        }
    }
}
