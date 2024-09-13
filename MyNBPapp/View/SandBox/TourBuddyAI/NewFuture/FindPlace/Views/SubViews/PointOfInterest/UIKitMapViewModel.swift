//
//  UIKitMapViewModel.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 13/09/2024.
//

import Foundation
import MapKit

class UIKitMapViewModel: ObservableObject {
    
    @Published var pointOfInterestCategories: [MKPointOfInterestCategory] = [.museum, .castle]
    @Published var searchResults: [MKPlacemark] = []
    
}
