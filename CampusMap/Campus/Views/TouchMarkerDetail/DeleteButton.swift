//
//  DeleteButton.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/11/23.
//

import SwiftUI

struct DeleteButton: View {
    @Environment(MapManager.self) var manager
    @Environment(\.dismiss) var dismiss
    let selectedTouchMarker : TouchMarker
    
    private let width = 25.0
    private let height = 25.0
    var body: some View {
        Button(action: {
            manager.removeTouchMarker(selectedTouchMarker)
            dismiss()
        }) {
            Image(systemName: "trash")
            .frame(width:width,height:height)
        }
        .clipShape(.circle)
        .tint(.red)
        .buttonStyle(.borderedProminent)
    }
}
