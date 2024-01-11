//
//  DirectionsButton.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/6/23.
//

import SwiftUI
import MapKit

struct DirectionsButton: View {
    @Environment(MapManager.self) var manager
    @Environment(\.dismiss) var dismiss
    var building : Building
    
    private let width = 25.0
    private let height = 25.0
    var body : some View {
        Menu {
            ForEach(manager.touchMarkers) {touchMarker in
                Button(action: {
                    manager.provideDirections(to: CLLocationCoordinate2D(building: building), from: touchMarker.coordinate)
                    dismiss()
                }) {
                    if let title = touchMarker.title {
                        Text("\(title): \(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                    } else {
                        Text("\(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                    }
                }
            }
            ForEach(manager.selectedBuildings) {selectedBuilding in
                if (building != selectedBuilding) {
                    Button(action: {
                        manager.provideDirections(to: CLLocationCoordinate2D(building: building), from: CLLocationCoordinate2D(building: selectedBuilding))
                        dismiss()
                    }) {
                        Text(selectedBuilding.name)
                    }
                }
            }
            if manager.locationManager.authorizationStatus == .authorizedAlways ||
                manager.locationManager.authorizationStatus == .authorizedWhenInUse {
                Button(action: {
                    if let userCoord = manager.locationManager.location?.coordinate {
                        manager.provideDirections(to: CLLocationCoordinate2D(building: building), from: userCoord)
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
