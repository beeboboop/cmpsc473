//
//  ShoppingListButtons.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/8/23.
//

import SwiftUI

struct ShoppingListButtonRow: View {
    let saveAction : () -> Void
    let deleteAction : () -> Void
    var isSaveable : Bool
    var body: some View {
        HStack {
            Spacer()
            ShoppingListButton(action: saveAction,
                               text: "Save to pantry",
                               color: .mint)
            .disabled(!isSaveable)
            .opacity(isSaveable ? 1 : 0.7)
            Spacer()
            ShoppingListButton(action: deleteAction,
                               text: "Clear list",
                               color: .red)
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
}

struct ShoppingListButton: View {
    let action : () -> Void
    let text : String
    let color : Color
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(width: 120)
                .foregroundStyle(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background {
                    Capsule()
                        .fill(color)
                }
        }
        .buttonStyle(.plain)
    }
}
