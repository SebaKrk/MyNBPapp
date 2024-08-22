//
//  PointOfInterest.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 22/08/2024.
//
import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = MKMapView
    
    var pointOfInterestCategories: [MKPointOfInterestCategory]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.pointOfInterestFilter = MKPointOfInterestFilter(including: pointOfInterestCategories)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapViewRepresentable
        var locationManager: CLLocationManager
        
        init(_ parent: MapViewRepresentable) {
            self.parent = parent
            self.locationManager = CLLocationManager()
            super.init()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            parent.updateRegion(region, animated: true)
        }
    }
    
    func updateRegion(_ region: MKCoordinateRegion, animated: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let mapView = window.rootViewController?.view.subviews.first(where: { $0 is MKMapView }) as? MKMapView {
            mapView.setRegion(region, animated: animated)
        }
    }
}
