//
//  FavoriteButton.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI

struct FavoriteButton: View {
    @Environment(MapManager.self) var manager
    @Environment(\.dismiss) var dismiss
    var building : Building
    
    private let width = 25.0
    private let height = 25.0
    var body : some View {
        let isBuildingFavorited = manager.buildings[manager.getBuildingIndexFrom(building)].isFavorited
        Button(action: {
            manager.toggleFavoriteOf(building)
            dismiss()
        }) {
            Image(systemName: isBuildingFavorited ? "heart.fill" : "heart")
            .frame(width: width,height: height)
        }
        .clipShape(.circle)
        .buttonStyle(.borderedProminent)
        .tint(isBuildingFavorited ? .pink : .gray)
        .animation(.linear.speed(2.5), value: isBuildingFavorited)
    }
}
