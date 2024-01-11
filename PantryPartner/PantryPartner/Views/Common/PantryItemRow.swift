//
//  PantryItemRow.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct PantryItemRow: View {
    @Environment(\.colorScheme) var colorScheme
    let pantryItem : PantryItem
    let deleteAction : (PantryItem) -> Void
    let isShoppingListItem : Bool
    
    var imageName : String {
        pantryItem.hasBeenBought ? "checkmark.square" : "square"
    }
    var imageColor : Color {
        pantryItem.hasBeenBought ? .blue : .gray
    }
    var strikedThrough : Bool {
        isShoppingListItem && pantryItem.hasBeenSaved && pantryItem.hasBeenBought
    }
    
    var body: some View {
        @Bindable var pantryItem = pantryItem
        ZStack(alignment: .leading) {
            HStack {
                if isShoppingListItem {
                    Button(action: {pantryItem.hasBeenBought.toggle()}) {
                        Image(systemName: imageName)
                            .foregroundStyle(imageColor)
                    }
                    .disabled(strikedThrough)
                }
                VStack(alignment: .leading) {
                    Text(pantryItem.name)
                        .font(.title3)
                    if !pantryItem.itemDescription.isEmpty {
                        Text(pantryItem.itemDescription)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                QuantityStepper(amount: isShoppingListItem ? 
                                $pantryItem.shoppingAmount : $pantryItem.pantryAmount)
                    .disabled(strikedThrough)
            }
            .overlay(alignment: .leading) {
                Capsule()
                    .frame(height: 3)
                    .scaleEffect(strikedThrough ? 1 : 0, anchor: .leading)
                    .animation(.easeInOut, value: strikedThrough)
            }
            .swipeActions(edge: .trailing) {
                Button(action: { deleteAction(pantryItem) }) {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
            .swipeActions(edge: .leading) {
                if !isShoppingListItem {
                    Button(action: { pantryItem.isInShoppingList = true }) {
                        Image(systemName: "cart.fill")
                    }
                    .tint(.mint)
                }
            }
        }
        .animation(.easeInOut, value: strikedThrough)
        .foregroundStyle(strikedThrough ? .gray : colorScheme == .dark ? .white : .black)
    }
}
