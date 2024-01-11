//
//  EmptyPantryView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct EmptyContentView: View {
    let labelText: String
    let imageName: String
    let description: String
    var body: some View {
        ContentUnavailableView {
            Label(labelText, systemImage: imageName)
        } description: {
            Text(description)
        }
    }
}
