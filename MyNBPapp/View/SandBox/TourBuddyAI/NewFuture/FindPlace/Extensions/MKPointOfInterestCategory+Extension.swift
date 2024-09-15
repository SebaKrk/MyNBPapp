//
//  MKPointOfInterestCategory+Extension.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 15/09/2024.
//

import MapKit

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
}
