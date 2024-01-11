//
//  Manager+CLDelegate.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/5/23.
//

import Foundation
import CoreLocation

extension MapManager : CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }
}
