//
//  MapManager.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import Foundation
import MapKit
import Observation
import _MapKit_SwiftUI

@Observable
class MapManager : NSObject {
    static let startLocation : MapCameraPosition = .rect(.init(origin: .init(.campusCenter), size: .init(width: 5500, height: 5500)))
    static let startRegion : MKCoordinateRegion = MKCoordinateRegion(center: .campusCenter, latitudinalMeters: 1000, longitudinalMeters: 1000)
    
    var buildings : [Building]
    var touchMarkers : [TouchMarker] = []
    
    let persister : Persistence
    let locationManager : CLLocationManager
    var route : MKRoute? = nil
    var currentStep : MKRoute.Step? = nil
    let formatter : DateComponentsFormatter = DateComponentsFormatter()
    
    var routeDestination : MKAnnotation? = nil
    var routeSource : MKAnnotation? = nil
    
    var filterOption : FilterOptions = .all
    var mapOptions : MapOptions = .standard
    
    var selectedBuilding : Building?
    var selectedTouchMarker : TouchMarker?
    
    override init() {
        persister = Persistence(fileName: "Buildings")
        if let loadedBuildings = persister.buildings {
            buildings = loadedBuildings.sorted(by: {$0.name<$1.name})
        } else {buildings = []}
        
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        locationManager = CLLocationManager()
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
}

//MARK: - Computed variables
extension MapManager {
    var selectedBuildings : [Building] {buildings.filter() {$0.isSelected}}
    var favoritedBuildings : [Building] {buildings.filter() {$0.isFavorited}}
    var isAllFavoritesSelected : Bool {!favoritedBuildings.isEmpty && favoritedBuildings.allSatisfy() {$0.isSelected}}
    var filteredBuildings : [Building] {
        switch filterOption {
        case .all:
            return buildings
        case .favorited:
            return favoritedBuildings
        case .selected:
            return selectedBuildings
        case .nearby:
            return findNearbyBuildings()
        }
    }
    var selectedBuildingAnnotations : [BuildingAnnotation] {selectedBuildings.map() {BuildingAnnotation(building: $0)}}
    var polylines : [MKPolyline]? {route?.steps.map() {$0.polyline}}
}


//MARK: - Functions
extension MapManager {
    func toggleSelectionOf(_ building: Building) {
        let index = buildings.firstIndex(where: {$0.id == building.id}) ?? 0
        buildings[index].isSelected.toggle()
        self.clearDirections()
    }
    
    func toggleFavoriteOf(_ building: Building) {
        let index = buildings.firstIndex(where: {$0.id == building.id}) ?? 0
        buildings[index].isFavorited.toggle()
    }
    
    func deselectAll() {
        for i in 0..<buildings.count {
            buildings[i].isSelected = false
        }
        self.clearDirections()
    }
    
    func switchSelectionOfFavorites() {
        if isAllFavoritesSelected {
            for i in 0..<buildings.count {
                if buildings[i].isFavorited {
                    buildings[i].isSelected = false
                }
            }
        }
        else {
            for i in 0..<buildings.count {
                if buildings[i].isFavorited {
                    buildings[i].isSelected = true
                }
            }
        }
        self.clearDirections()
    }
    
    func getBuildingIndexFrom(_ building: Building) -> Int {
        return buildings.firstIndex(where: {$0.id == building.id}) ?? 0
    }
    
    func getBuildingFromAnnotation(_ annotation: BuildingAnnotation) -> Building? {
        return buildings.first(where: {$0.id == annotation.id})
    }
    
    func getAnnotationFromBuilding(_ building: Building) -> BuildingAnnotation? {
        return selectedBuildingAnnotations.first(where: {$0.id == building.id})
    }
    
    func getAnnotationFromCoordinate(_ coordinate: CLLocationCoordinate2D) -> MKAnnotation? {
        for buildingAnnotation in self.selectedBuildingAnnotations {
            if buildingAnnotation.coordinate == coordinate {
                return buildingAnnotation
            }
        }
        for touchMarker in self.touchMarkers {
            if touchMarker.coordinate == coordinate {
                return touchMarker
            }
        }
        return nil
    }
    
    func removeTouchMarker(_ touchMarker: TouchMarker) {
        self.touchMarkers.removeAll(where: {$0.coordinate == touchMarker.coordinate})
        self.clearDirections()
    }
    
    func removeAllTouchMarkers() {
        self.touchMarkers.removeAll()
        self.clearDirections()
    }
    
    func findNearbyBuildings() -> [Building] {
        // nearby defined as <804 meters ~ 0.5 miles ~ 10 minute walk
        return buildings.filter() {
            if let location = locationManager.location {
                return location.distance(from: CLLocation(latitude: $0.latitude, longitude: $0.longitude)) < 804
            }
            return false
        }
    }
    
    func save() {
        persister.save(buildings: buildings)
    }
}

