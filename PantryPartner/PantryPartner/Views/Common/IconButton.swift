//
//  IconButton.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct IconButton: View {
    let imageName : String
    let backgroundColor : Color
    let action : () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                    .foregroundStyle(backgroundColor)
        }
        .scaleEffect(1.5)
        .frame(width: 32, height: 32)
        .buttonStyle(.plain)
    }
}

#Preview {
    IconButton(imageName: "plus.circle.fill", backgroundColor: .mint, action: {})
}
