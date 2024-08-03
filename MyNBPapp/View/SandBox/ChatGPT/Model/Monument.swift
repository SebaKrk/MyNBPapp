//
//  Monument.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 03/08/2024.
//

import Foundation
import CoreLocation

struct Monument: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let location: Location
}

struct Location: Hashable{
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension CLLocationCoordinate2D {
    static let wawelCastle = CLLocationCoordinate2D(latitude: 50.0547, longitude: 19.9352)
    static let mainSquare = CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9370)
    static let stMarysBasilica = CLLocationCoordinate2D(latitude: 50.0616, longitude: 19.9390)
    static let barbican = CLLocationCoordinate2D(latitude: 50.0654, longitude: 19.9421)
    static let kazimierz = CLLocationCoordinate2D(latitude: 50.0480, longitude: 19.9445)
}
