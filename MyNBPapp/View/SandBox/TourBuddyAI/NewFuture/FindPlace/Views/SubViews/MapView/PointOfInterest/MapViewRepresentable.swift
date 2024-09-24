//
//  MapViewRepresentable.swift
//  MyNBPapp
//
//  Created by Sebastian Sciuba on 22/08/2024.
//
import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    
//    typealias UIViewType = MKMapView
    
    @ObservedObject var viewModel: UIKitMapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.pointOfInterestFilter = MKPointOfInterestFilter(including: viewModel.pointOfInterestCategories)
        
        uiView.removeAnnotations(uiView.annotations)
        
        let annotations = viewModel.searchResults.map { placemark -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = placemark.placemark.coordinate
            annotation.title = placemark.name
            return annotation
        }
        
        uiView.addAnnotations(annotations)
        
        if let firstResult = viewModel.searchResults.first {
            let region = MKCoordinateRegion(center: firstResult.placemark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            uiView.setRegion(region, animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: MapViewRepresentable
        var locationManager = LocationManager.shared
        
        init(_ parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
            locationManager.requestAuthorization()
            locationManager.startUpdatingLocation()
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
