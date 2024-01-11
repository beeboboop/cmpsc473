//
//  TouchMarker.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import Foundation
import MapKit

class TouchMarker : NSObject, MKAnnotation, Identifiable {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    var id : UUID = UUID()
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
}
