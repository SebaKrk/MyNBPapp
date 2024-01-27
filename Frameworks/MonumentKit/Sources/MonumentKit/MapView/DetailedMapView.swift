//
//  DetailedMapView.swift
//
//
//  Created by Sebastian Sciuba on 26/01/2024.
//

import SwiftUI
import MapKit

/// `DetailedMapView` is a structure representing a map view in SwiftUI, embedded using `UIViewControllerRepresentable`.
struct DetailedMapView: UIViewControllerRepresentable {
    
    /// The ViewController type used in this representation.
    typealias ViewController = UIViewController

    /// The location to display on the map.
    var location: CLLocation

    /// The distance from the location to set the camera's view. Default is 1000 meters.
    var distance: Double = 1000

    /// The pitch angle of the camera. Default is 0 (straight down).
    var pitch: Double = 0

    /// The heading of the camera in degrees. Default is 0 (north).
    var heading: Double = 0

    /// Top safe area inset to be applied.
    var topSafeAreaInset: Double

    /// A subclass of `ViewController` configured to display a map.
    class Controller: ViewController {
        /// The mapView being displayed.
        var mapView: MKMapView {
            guard let tempView = view as? MKMapView else {
                fatalError("View could not be cast as MapView.")
            }
            return tempView
        }
        
        /// Configures the view as an MKMapView with certain properties and settings.
        override func loadView() {
            let mapView = MKMapView()
            view = mapView
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            let configuration = MKStandardMapConfiguration(elevationStyle: .realistic, emphasisStyle: .default)
            configuration.pointOfInterestFilter = .excludingAll
            configuration.showsTraffic = false
            mapView.preferredConfiguration = configuration
            mapView.isZoomEnabled = false
            mapView.isPitchEnabled = false
            mapView.isScrollEnabled = false
            mapView.isRotateEnabled = false
            mapView.showsCompass = false
        }
    }
        
    /// Creates the view controller to be presented.
    func makeUIViewController(context: Context) -> Controller {
        Controller()
    }
    
    /// Updates the view controller and its views.
    func updateUIViewController(_ controller: Controller, context: Context) {
        update(controller: controller)
    }

    /// Helper method to update the map view controller.
    private func update(controller: Controller) {
        controller.additionalSafeAreaInsets.top = topSafeAreaInset
        controller.mapView.camera = MKMapCamera(
            lookingAtCenter: location.coordinate,
            fromDistance: distance,
            pitch: pitch,
            heading: heading
        )
    }
    
}
