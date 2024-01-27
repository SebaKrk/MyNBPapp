//
//  MonumentShowcaseView.swift
//
//
//  Created by Sebastian Sciuba on 26/01/2024.
//

import SwiftUI
import DataModels

public struct MonumentShowcaseView: View {
    
    var monument: MonumentLocation
    var topSafeAreaInset: Double
    var animated: Bool
    
    public init(monument: MonumentLocation, topSafeAreaInset: Double, animated: Bool = true) {
        self.monument = monument
        self.topSafeAreaInset = topSafeAreaInset
        self.animated = animated
    }
    
    public var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation(paused: !animated)) { context in
                let seconds = context.date.timeIntervalSince1970
                let rotationPeriod = 240.0
                let headingDelta = seconds.percent(truncation: rotationPeriod)
                let pitchPeriod = 60.0
                let pitchDelta = seconds
                    .percent(truncation: pitchPeriod)
                    .symmetricEaseInOut()
                
                let viewWidthPercent = (350.0 ... 1000).percent(for: proxy.size.width)
                let distanceMultiplier = (1 - viewWidthPercent) * 0.5 + 1
                
                DetailedMapView(
                    location: monument.location,
                    distance: distanceMultiplier * monument.cameraDistance,
                    pitch: (50...60).value(percent: pitchDelta),
                    heading: 360 * headingDelta,
                    topSafeAreaInset: topSafeAreaInset
                )
            }
        }
    }
    
}
