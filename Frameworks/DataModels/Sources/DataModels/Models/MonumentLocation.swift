//
//  MonumentLocation.swift
//
//
//  Created by Sebastian Sciuba on 26/01/2024.
//

import Foundation
import CoreLocation

/// `MonumentLocation` is a structure representing a specific monument location.
public struct MonumentLocation: Identifiable, Hashable {
    
    // MARK: - Properties
    
    /// Unique identifier for the monument location, derived from its name.
    public var id: String { name }
    
    /// The name of the monument.
    public var name: String
    
    /// The geographical location (latitude and longitude) of the monument.
    public var location: CLLocation
    
    /// A textual description of the monument.
    public var description: String
    
    /// Default distance for the camera view when the monument is displayed on a map. Default is 1000 meters.
    public var cameraDistance: Double = 1000
    
    // MARK: - Lifecycle
    
    public init(name: String,
         location: CLLocation,
         description: String,
         cameraDistance: Double) {
        self.name = name
        self.location = location
        self.description = description
        self.cameraDistance = cameraDistance
    }
    
}
