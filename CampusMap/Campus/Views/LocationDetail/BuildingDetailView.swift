//
//  BuildingDetailView.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI
import MapKit

struct BuildingDetailView: View {
    @Binding var position : MapCameraPosition
    let building : Building
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(building.name)
                        .font(.title3)
                    if let yearConstructed = building.yearConstructed {
                        Text("Built in \(String(yearConstructed))")
                            .font(.subheadline)
                    }
                }
                Spacer()
                DirectionsButton(building: building)
                    .padding([.leading])
                FavoriteButton(building: building)
                    .padding([.trailing])
            }
            .padding([.leading, .top])
            if let photo = building.photo {
                Image(photo)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 20)))
                    .scaledToFit()
            }
        }
    }
}
