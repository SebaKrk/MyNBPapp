//
//  MonumentData.swift
//  
//
//  Created by Sebastian Sciuba on 27/01/2024.
//

import Foundation
import CoreLocation
import DataModels

/// `MonumentData` provides a collection of predefined `MonumentLocation` instances.
///
/// This structure contains static properties that represent various notable monuments
/// and their associated data. Each property is an instance of `MonumentLocation`
/// and includes the monument's name, geographical location, description, and
/// a default camera distance for map displays.
///
public struct MonumentData {

    public static let nbp = MonumentLocation(
        name: String(localized: "Narodowy Bank Polski", comment: "Central bank of Poland located in Warsaw"),
        location: CLLocation(latitude: 52.236177, longitude: 21.014759),
        description: String(localized: "Narodowy Bank Polski, located at ul. Świętokrzyska 11/21, is the central bank of Poland, responsible for the country's monetary policy and financial stability."),
        cameraDistance: 300
    )
    
}
