//
//  UIMap.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/10/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Environment(MapManager.self) var manager
    @Binding var selectedBuilding : Building?
    @Binding var selectedTouchMarker : TouchMarker?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsUserTrackingButton = true
        mapView.region = manager.selectedBuildings.isEmpty ? MapManager.startRegion : MKCoordinateRegion(annotations: mapView.annotations)
        mapView.delegate = context.coordinator
        mapView.preferredConfiguration = MKStandardMapConfiguration()
        
        let lpgr = UILongPressGestureRecognizer(target: mapView.delegate,
                                                action:#selector(MapViewCoordinator.handleLongPress(_ :)))
        lpgr.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(lpgr)

        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations.filter ({$0.title != selectedBuilding?.name && $0.coordinate != selectedTouchMarker?.coordinate}))
        mapView.addAnnotations(manager.selectedBuildingAnnotations)
        mapView.addAnnotations(manager.touchMarkers)
        
        mapView.removeOverlays(mapView.overlays)
        if let route = manager.route {
            mapView.removeAnnotations(mapView.annotations.filter({
                $0.coordinate != manager.routeDestination?.coordinate && $0.coordinate != manager.routeSource?.coordinate
            }))
            mapView.addOverlays(route.steps.map({$0.polyline}))
            if let currentStep = manager.currentStep {
                mapView.addOverlay(currentStep.polyline)
            }
            if manager.routeSource != nil {
                mapView.showsUserLocation = false
            }
            mapView.setRegion(MKCoordinateRegion(annotations: mapView.annotations), animated: true)
            mapView.showsUserLocation = true
        } else if (!manager.selectedBuildings.isEmpty || !manager.touchMarkers.isEmpty) && mapView.selectedAnnotations.isEmpty {
            mapView.setRegion(MKCoordinateRegion(annotations: mapView.annotations), animated: true)
        } else if mapView.selectedAnnotations.isEmpty {
            mapView.setRegion(MapManager.startRegion, animated: true)
        }
        
        switch manager.mapOptions {
        case .standard:
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        case .hybrid:
            mapView.preferredConfiguration = MKHybridMapConfiguration()
        case .imagery:
            mapView.preferredConfiguration = MKImageryMapConfiguration()
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(manager: manager)
    }
    

}
