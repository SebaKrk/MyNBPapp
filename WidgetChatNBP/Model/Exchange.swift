//
//  Exchange.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 28/04/2024.
//

import Foundation

struct Exchange: Equatable, Decodable {
    let table: String
    let currency: String
    let code: String
    var rates: [ChartData]
}
