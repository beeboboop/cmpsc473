//
//  MapTopControls.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI
import MapKit

struct MapTopControls: View {
    @Environment(MapManager.self) var manager
    @Binding var isPresentingBuildingsSheet : Bool
    var body: some View {
        HStack{
            Spacer()
            Button(action: {isPresentingBuildingsSheet.toggle()}) {
                Image(systemName: "checklist")
            }            
            Spacer()
            Button(action: {manager.switchSelectionOfFavorites()}) {
                Image(systemName: manager.isAllFavoritesSelected ? "heart.fill" : "heart")
            }
            .disabled(manager.favoritedBuildings.isEmpty)
            Spacer()
            Menu {
                ForEach(MapOptions.allCases, id:\.self) {option in
                    Button(action: {manager.mapOptions = option}) {
                        Label(option.rawValue, systemImage: manager.mapOptions == option ? "checkmark.square" : "square")
                    }
                }
            } label: {
                Image(systemName: "map")
            }
            Spacer()
            Button(role: .destructive, action: {manager.deselectAll()}) {
                Image(systemName: "mappin.slash")
            }
            .disabled(manager.selectedBuildings.isEmpty)
            Spacer()
            Button(role: .destructive, action: {manager.removeAllTouchMarkers()}) {
                Image(systemName: "trash")
            }
            Spacer()
         }
    }
}
