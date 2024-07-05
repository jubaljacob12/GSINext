//
//  LCMapViewRepresentable.swift
//  NextApp
//
//  Created by JJMac on 3/07/24.
//


import SwiftUI
import MapKit

struct LCMapViewRepresentable: UIViewRepresentable{
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @State private var isUserInteracting = false
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.isZoomEnabled = true
        mapView.showsUserLocation =  true
        mapView.userTrackingMode = .follow
        
        // Track user interaction to prevent unwanted map resets
        mapView.addGestureRecognizer(UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleMapPan)))
        mapView.addGestureRecognizer(UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleMapPinch)))
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = locationViewModel.selectedLCLocation?.coordinate{
                print("DEBUG: Adding stuff to map...")
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        case .polylineAdded:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension LCMapViewRepresentable{
    class MapCoordinator: NSObject, MKMapViewDelegate{
        //MARK: - properties
        let parent: LCMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        //MARK: - lifecycle
        init(parent: LCMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        //delegate method for when user updates location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            guard !parent.isUserInteracting else { return }
            
            self.userLocationCoordinate = userLocation.coordinate
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)

        }
        
        //delegate method to tell the mapViewDelegate to draw an overlay using a renderer object
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemPurple
            polyline.lineWidth = 6
            return polyline
        }
        
        @objc func handleMapPan() {
            parent.isUserInteracting = true
        }

        @objc func handleMapPinch() {
            parent.isUserInteracting = true
        }

        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.isUserInteracting = false
        }

        
        //MARK: - helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            //remove previous annotations
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D){
            guard let userLocationCoordinate = self.userLocationCoordinate else {return}
            parent.locationViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                //reframing our mapView to fit our annotations when location is selected w cab options in RideRequestView
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                
            }
        }
        
        
        
        
        func clearMapViewAndRecenterOnUserLocation() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion =  currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
    }
    
}
