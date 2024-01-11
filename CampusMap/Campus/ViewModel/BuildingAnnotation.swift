//
//  BuildingAnnotation.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/10/23.
//

import Foundation
import MapKit

class BuildingAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    var isFavorited: Bool
    let id: Int
    
    required init(building: Building) {
        title = building.name
        coordinate = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
        isFavorited = building.isFavorited
        id = building.id
        super.init()
    }
}
