//
//  MKPointOfInterestCategory+Extension.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/09/2024.
//

import MapKit
import SwiftUI

extension MKPointOfInterestCategory {
    
    func displayName() -> String {
        switch self {
        case .amusementPark:
            return "Park Rozrywki"
        case .aquarium:
            return "Akwarium"
        case .museum:
            return "Muzeum"
        case .castle:
            return "Zamek"
        case .fortress:
            return "Forteca"
        case .landmark:
            return "Miejsce Historyczne"
        case .library:
            return "Biblioteka"
        case .nationalMonument:
            return "Pomnik Narodowy"
        case .planetarium:
            return "Planetarium"
        case .school:
            return "Szkoła"
        case .university:
            return "Uniwersytet"
        default:
            return "Inne"
        }
    }
    
    func imagePOI() -> String {
        switch self {
        case .amusementPark: return "mountain.2"
        case .aquarium: return "cat"
        case .castle: return "house"
        case .museum: return "building.columns"
            
        default:
            return "default"
        }
    }
    
    func backgroundPOI() -> Color {
        switch self {
        case .amusementPark: return .pink
        case .aquarium: return .blue
        case .castle: return .yellow
        case .museum: return .pink
            
        default:
            return .white
        }
    }

}
