//
//  MKCoordinateRegionConvenience.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    init(annotations: [MKAnnotation]) {
        var maxLong : CLLocationDegrees = -180
        var minLong : CLLocationDegrees = 180
        var maxLat : CLLocationDegrees = -90
        var minLat : CLLocationDegrees = 90
        for annotation in annotations {
            if annotation.coordinate.longitude > maxLong {
                maxLong = annotation.coordinate.longitude
            }
            if annotation.coordinate.longitude < minLong {
                minLong = annotation.coordinate.longitude
            }
            if annotation.coordinate.latitude > maxLat {
                maxLat = annotation.coordinate.latitude
            }
            if annotation.coordinate.latitude < minLat {
                minLat = annotation.coordinate.latitude
            }
        }
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: maxLat-minLat+0.001, longitudeDelta: maxLong-minLong+0.01)
        let center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (maxLat+minLat)/2, longitude: (maxLong+minLong)/2)
        self.init(center: center, span: span)
    }
}
