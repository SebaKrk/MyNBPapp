//
//  MapViewModelProtocol.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 14/09/2024.
//

import Foundation
import MapKit

protocol MapViewModelProtocol: ObservableObject {
    
    var search: String { get set }
    
    var searchResults: [MKMapItem] { get set }
    
    func findPlace(for searchText: String) async
    
}

