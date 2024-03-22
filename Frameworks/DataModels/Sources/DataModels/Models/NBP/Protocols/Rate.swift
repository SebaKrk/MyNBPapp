//
//  Rate.swift
//
//
//  Created by Sebastian Sciuba on 14/03/2024.
//

import Foundation

public protocol Rate: Decodable {
    
    var no: String { get }
    
    var effectiveDate: String { get }
    
}
