//
//  TouchDirectionsButton.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import SwiftUI
import MapKit

struct TouchDirectionsButton: View {
    @Environment(MapManager.self) var manager
    let selectedTouchMarker : TouchMarker
    @Environment(\.dismiss) var dismiss
    
    private let width = 25.0
    private let height = 25.0
    var body : some View {
        Menu {
            ForEach(manager.touchMarkers) {touchMarker in
                if selectedTouchMarker.coordinate != touchMarker.coordinate {
                    Button(action: {
                        manager.provideDirections(to: selectedTouchMarker.coordinate, from: touchMarker.coordinate)
                        dismiss()
                    }) {
                        if let title = touchMarker.title {
                            Text("\(title): \(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                        } else {
                            Text("\(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                        }
                    }
                }
            }
            ForEach(manager.selectedBuildings) {selectedBuilding in
                Button(action: {
                    manager.provideDirections(to: selectedTouchMarker.coordinate,
                                              from: CLLocationCoordinate2D(building: selectedBuilding))
                    dismiss()
                }) {
                    Text(selectedBuilding.name)
                }
            }
            if manager.locationManager.authorizationStatus == .authorizedAlways ||
                manager.locationManager.authorizationStatus == .authorizedWhenInUse {
                Button(action: {
                    if let userCoord = manager.locationManager.location?.coordinate {
                        manager.provideDirections(to: selectedTouchMarker.coordinate, from: userCoord)
                        dismiss()
                    }
                }) {
                    Text("Current Location")
                }
            }
            Text("Get directions from:")
        } label: {
            Image(systemName: "figure.walk")
                .frame(width:width, height:height)
        }
        .clipShape(.circle)
        .buttonStyle(.borderedProminent)
    }
}
