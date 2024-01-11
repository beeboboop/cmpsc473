//
//  Manager+CLLocation.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/5/23.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    static let campusCenter = CLLocationCoordinate2D(latitude: 40.797831, longitude: -77.864453)
    
    init(building: Building) {
        self = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
    }
}

extension CLLocationCoordinate2D : Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
