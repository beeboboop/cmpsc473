//
//  ShoppingView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import SwiftUI
import SwiftData

struct ShoppingView: View {
    @Environment(\.modelContext) var context
    
    @State private var isAdding : Bool = false
    @State private var presentTemplatesView : Bool = false
    
    @Query(filter: #Predicate<PantryItem> {$0.isInShoppingList}, sort: [SortDescriptor(\PantryItem.hasBeenSaved), SortDescriptor(\PantryItem.hasBeenBought), SortDescriptor(\PantryItem.name)]) private var shoppingListItems : [PantryItem] = []
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                if shoppingListItems.isEmpty {
                    EmptyContentView(labelText: "Your shopping list is empty", 
                                     imageName: "face.dashed", 
                                     description: "Press the \"+\" button to add an item or \"View Templates\" to use a template")
                } else {
                    List {
                        ForEach(shoppingListItems) {pantryItem in
                            PantryItemRow(pantryItem: pantryItem,
                                          deleteAction: removeItem(pantryItem:),
                                          isShoppingListItem: true)
                        }
                        ShoppingListButtonRow(saveAction: saveToPantry,
                                              deleteAction: removeAll,
                                              isSaveable: isSaveable)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(imageName: "plus.circle.fill",
                               backgroundColor: .orangeButton,
                               action: {isAdding.toggle()})
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {presentTemplatesView.toggle()}) {
                        Text("View Templates")
                            .foregroundStyle(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background {
                                Capsule()
                                    .fill(.orangeButton)
                            }
                    }
                }
            }
        }
        .animation(.easeInOut, value: shoppingListItems)
        .sheet(isPresented: $isAdding) {
            AddItemView(isShoppingListItem: true,
                        adding: addItem(_:description:amount:),
                        title: "Add to shopping list")
        }
        .sheet(isPresented: $presentTemplatesView) {
            TemplatesView()
        }
    }
}

#Preview {
    ShoppingView()
        .modelContainer(for: [PantryItem.self, ShoppingTemplate.self], inMemory: true)
}

extension ShoppingView {
    var isSaveable : Bool {
        shoppingListItems.contains(where: {$0.hasBeenBought && !$0.hasBeenSaved})
    }
}

extension ShoppingView {
    func addItem(_ name: String, description: String, amount: Int) {
        let pantryItem = PantryItem(name: name, itemDescription: description, pantryAmount: 0, shoppingAmount: amount, isInShoppingList: true, isInPantry: false)
        context.insert(pantryItem)
    }
    
    func removeItem(pantryItem: PantryItem) {
        if pantryItem.isInPantry {
            pantryItem.isInShoppingList = false
        } else {
            context.delete(pantryItem)
        }
    }
    
    func removeAll() {
        for pantryItem in shoppingListItems {
            if pantryItem.isInPantry {
                pantryItem.isInShoppingList = false
                pantryItem.hasBeenSaved = false
                pantryItem.hasBeenBought = false
            } else {
                context.delete(pantryItem)
            }
        }
    }
    
    func saveToPantry() {
        for pantryItem in shoppingListItems {
            if pantryItem.hasBeenBought  && !pantryItem.hasBeenSaved {
                if pantryItem.isInPantry {
                    pantryItem.pantryAmount += pantryItem.shoppingAmount
                    pantryItem.hasBeenSaved = true
                } else {
                    pantryItem.isInPantry = true
                    pantryItem.pantryAmount = pantryItem.shoppingAmount
                    pantryItem.hasBeenSaved = true
                }
            }
        }
    }
}

