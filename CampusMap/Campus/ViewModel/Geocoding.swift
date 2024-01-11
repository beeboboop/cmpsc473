//
//  Geocoding.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import Foundation
import MapKit

extension MapManager {
    func geocodeTouchmarkLocation(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placeMark, error in
            guard error == nil else {return}
            if let placeMark = placeMark?.first {
                if self.getAnnotationFromCoordinate(coordinate) == nil {
                    self.touchMarkers.append(TouchMarker(coordinate: coordinate, title: placeMark.thoroughfare))
                }
            }
        }
    }
}
