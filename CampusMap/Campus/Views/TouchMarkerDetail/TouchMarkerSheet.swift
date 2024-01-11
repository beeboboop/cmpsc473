//
//  TouchMarkerSheet.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import SwiftUI

struct TouchMarkerSheet: View {
    @Environment(MapManager.self) var manager
    
    let touchMarker : TouchMarker
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    if let title = touchMarker.title {
                        Text(title)
                            .font(.title3)
                        Text("\(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                            .font(.subheadline)
                    } else {
                        Text("\(touchMarker.coordinate.latitude)\u{00B0}, \(touchMarker.coordinate.longitude)\u{00B0}")
                            .font(.title3)
                    }
                }
                Spacer()
                TouchDirectionsButton(selectedTouchMarker: touchMarker)
                    .padding([.leading])
                DeleteButton(selectedTouchMarker: touchMarker)
                    .padding([.trailing])
            }
            .padding([.leading, .top])
        }
    }
}

