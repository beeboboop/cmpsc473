//
//  Directions.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/7/23.
//

import Foundation
import MapKit

extension MapManager {
    func provideDirections(to destinationCoord: CLLocationCoordinate2D, from sourceCoord: CLLocationCoordinate2D) {
        self.route = nil
        self.currentStep = nil
        self.routeDestination = getAnnotationFromCoordinate(destinationCoord)
        if sourceCoord == self.locationManager.location?.coordinate {
            self.routeSource = nil
        }
        else {
            self.routeSource = getAnnotationFromCoordinate(sourceCoord)
        }
        let request = MKDirections.Request()
        let destinationItem = MKMapItem(placemark: .init(coordinate: destinationCoord))
        let sourceItem = MKMapItem(placemark: .init(coordinate: sourceCoord))
        request.destination = destinationItem
        request.source = sourceItem
        request.transportType = .walking
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            guard error == nil else {return}
            if let route = response?.routes.first {
                self.route = route
                self.currentStep = route.steps.first
            }
        }
    }
    
    var nextStep : MKRoute.Step? {
        if let route = self.route, let step = self.currentStep {
            guard let currIndex = route.steps.firstIndex(of: step) else {return nil}
            if currIndex < route.steps.count - 1 {
                return route.steps[currIndex + 1]
            }
        }
        return nil
    }
    
    var prevStep : MKRoute.Step? {
        if let route = self.route, let step = self.currentStep {
            guard let currIndex = route.steps.firstIndex(of: step) else {return nil}
            if currIndex > 0 {
                return route.steps[currIndex - 1]
            }
        }
        return nil
    }
    
    func clearDirections() {
        self.route = nil
        self.currentStep = nil
        self.routeDestination = nil
        self.routeSource = nil
    }
}
