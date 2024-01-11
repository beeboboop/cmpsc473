//
//  EditTemplateView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/9/23.
//

import SwiftUI

struct EditTemplateView: View {
    let template : ShoppingTemplate
    @State private var isAdding : Bool = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                if template.items.isEmpty {
                    EmptyContentView(labelText: "This template has no items", 
                                     imageName: "face.dashed",
                                     description: "Press the \"+\" to add an item")
                } else {
                    List {
                        ForEach(template.items.sorted(by: {$0.name < $1.name})) {pantryItem in
                            PantryItemRow(pantryItem: pantryItem,
                                          deleteAction: removeItem(pantryItem:),
                                          isShoppingListItem: false)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle(template.name)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(imageName: "plus.circle.fill",
                               backgroundColor: .orangeButton,
                               action: {isAdding.toggle()})
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            AddItemView(isShoppingListItem: true,
                        adding: addItem(_:description:amount:),
                        title: "Add to \(template.name)")
        }
    }
}

extension EditTemplateView {
    func removeItem(pantryItem: PantryItem) {
        template.items.removeAll(where: {$0 == pantryItem})
    }
    
    func addItem(_ name: String, description: String, amount: Int) {
        let pantryItem = PantryItem(name: name, itemDescription: description, 
                                    pantryAmount: amount, shoppingAmount: amount,
                                    isInShoppingList: false, isInPantry: false)
        template.items.append(pantryItem)
    }
}
