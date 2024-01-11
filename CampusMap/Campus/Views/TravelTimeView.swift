//
//  TravelTimeView.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/8/23.
//

import SwiftUI

struct TravelTimeView: View {
    @Environment(MapManager.self) var manager
    
    var body: some View {
        if let travelTime = manager.route?.expectedTravelTime {
            VStack(alignment: .leading) {
                Text("Travel time: ").font(.subheadline)
                Text(manager.formatter.string(from: travelTime) ?? "").font(.title3)
            }
            .padding([.leading, .trailing])
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(0.7))
            .position(x: CGFloat(65), y: CGFloat(30))
            .foregroundStyle(.white)
        }
    }
}
