//
//  LocalSearchServices.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 02/08/2024.
//

import Foundation
import MapKit

class LocalSearchServices {
    
    func searchPlace(center: CLLocationCoordinate2D) async throws -> MKMapItem? {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Monument"
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: 100,
                                            longitudinalMeters: 100)
        
        let search = MKLocalSearch(request: request)
        
        return try await withCheckedThrowingContinuation { continuation in
            search.start { response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: response?.mapItems.first)
                }
            }
        }
//        return response.mapItems.first
    }
  
}
