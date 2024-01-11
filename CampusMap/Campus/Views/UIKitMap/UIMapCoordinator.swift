//
//  UIMapCoordinator.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/10/23.
//

import Foundation
import MapKit

class MapViewCoordinator : NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
    let manager : MapManager
    
    required init(manager: MapManager) {
        self.manager = manager
        super.init()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if manager.route != nil {
            if annotation.coordinate == manager.routeSource?.coordinate {
                let markerID = "routeSource"
                let marker =  (mapView.dequeueReusableAnnotationView(withIdentifier: markerID) ??
                               MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerID)) as! MKMarkerAnnotationView
                marker.markerTintColor = .systemGreen
                if let annotation = annotation as? BuildingAnnotation {
                    marker.glyphImage = annotation.isFavorited ? UIImage(systemName: "heart") : UIImage(systemName: "mappin")
                }
                return marker
            }
            else if annotation.coordinate == manager.routeDestination?.coordinate {
                let markerID = "routeDestination"
                let marker =  (mapView.dequeueReusableAnnotationView(withIdentifier: markerID) ??
                               MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerID)) as! MKMarkerAnnotationView
                marker.markerTintColor = .systemBlue
                if let annotation = annotation as? BuildingAnnotation {
                    marker.glyphImage = annotation.isFavorited ? UIImage(systemName: "heart") : UIImage(systemName: "mappin")
                }
                return marker
            }
        }
        else if let annotation = annotation as? BuildingAnnotation {
            let markerID = "building"
            let marker =  (mapView.dequeueReusableAnnotationView(withIdentifier: markerID) ??
                           MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerID)) as! MKMarkerAnnotationView
            marker.markerTintColor = annotation.isFavorited ? .systemPink : .systemCyan
            marker.glyphImage = annotation.isFavorited ? UIImage(systemName: "heart") : UIImage(systemName: "mappin")
            return marker
        }
        else if annotation.isMember(of: TouchMarker.self) {
            let markerID = "touch"
            let marker =  (mapView.dequeueReusableAnnotationView(withIdentifier: markerID) ??
                           MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerID)) as! MKMarkerAnnotationView
            marker.markerTintColor = .systemGray
            marker.glyphImage = UIImage(systemName: "mappin")
            return marker
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        if let annotation = annotation as? BuildingAnnotation {
            manager.selectedBuilding = manager.getBuildingFromAnnotation(annotation)
        }
        if let annotation = annotation as? TouchMarker {
            manager.selectedTouchMarker = annotation
        }
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline, let currentStep = manager.currentStep {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = polyline == currentStep.polyline ? .systemRed : .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
        
        return MKOverlayRenderer()
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    }
    
    @objc func handleLongPress(_ longPressGesture: UILongPressGestureRecognizer) {
        if longPressGesture.state != .began {return}
        
        if manager.route == nil {
            let mapView = longPressGesture.view as! MKMapView
            let touchPoint = longPressGesture.location(in: mapView)
            let touchMarkerCoords = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let coordinate = CLLocationCoordinate2D(latitude: touchMarkerCoords.latitude, longitude: touchMarkerCoords.longitude)
            manager.geocodeTouchmarkLocation(coordinate)
        }
    }
}
