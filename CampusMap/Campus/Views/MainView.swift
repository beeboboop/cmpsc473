//
//  MainView.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI
import MapKit

struct MainView: View {
    @Environment(MapManager.self) var manager
    @State private var position : MapCameraPosition = MapManager.startLocation
    @State private var isPresentingBuildingsSheet : Bool = false
    @State private var longPressLocation : CGPoint = CGPoint(x: 0, y: 0)
    var body: some View {
        @Bindable var manager = manager
        ZStack {
            MapView(selectedBuilding: $manager.selectedBuilding,
                    selectedTouchMarker: $manager.selectedTouchMarker)
            
            TravelTimeView()
        }
        .ignoresSafeArea()
        .padding([.top])
        .sheet(isPresented: $isPresentingBuildingsSheet) {
            BuildingListSheet()
        }
        .sheet(item: $manager.selectedBuilding) { building in
            BuildingDetailView(position: $position, building: building)
                .presentationDetents([building.photo != nil ? .fraction(0.4) : .fraction(0.1)])
        }
        .sheet(item: $manager.selectedTouchMarker) { touchMarker in
            TouchMarkerSheet(touchMarker: touchMarker)
                .presentationDetents([.fraction(0.1)])
        }
        .safeAreaInset(edge: .top) {
            MapTopControls(isPresentingBuildingsSheet: $isPresentingBuildingsSheet)
        }
        .safeAreaInset(edge: .bottom) {
            DirectionsView()
                .ignoresSafeArea()
        }
    }
}
