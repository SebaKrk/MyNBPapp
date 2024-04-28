//
//  WidgetEntry.swift
//  WidgetChatNBPExtension
//
//  Created by Sebastian Sciuba on 28/04/2024.
//

import Foundation
import WidgetKit

struct WidgetEntry: TimelineEntry {
    let date: Date
    let chartData: [ChartData]
}
