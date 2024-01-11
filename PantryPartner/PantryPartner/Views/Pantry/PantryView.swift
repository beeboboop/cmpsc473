//
//  PantryView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import SwiftUI
import SwiftData

struct PantryView: View {
    @Environment(\.modelContext) var context
    
    @State private var isAdding : Bool = false
    
    @Query(filter: #Predicate<PantryItem> {$0.isInPantry}, sort: [SortDescriptor(\PantryItem.name)]) private var pantryItems : [PantryItem] = []
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                if pantryItems.isEmpty {
                    EmptyContentView(labelText: "Your pantry is empty",
                                     imageName: "face.dashed",
                                     description: "Press the \"+\" button to add an item")
                }
                List {
                    ForEach(pantryItems) {pantryItem in
                        PantryItemRow(pantryItem: pantryItem,
                        deleteAction: removeItem(pantryItem:),
                        isShoppingListItem: false)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Pantry")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(imageName: "plus.circle.fill", 
                               backgroundColor: .orangeButton,
                               action: {isAdding.toggle()})
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            AddItemView(isShoppingListItem: false,
                        adding: addItem(_:description:amount:),
                        title: "Add to pantry")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PantryItem.self, configurations: config)
        return PantryView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}

extension PantryView {
    func addItem(_ name: String, description: String, amount: Int) {
        let item = PantryItem(name: name, itemDescription: description, pantryAmount: amount, shoppingAmount: 0, isInShoppingList: false, isInPantry: true)
        context.insert(item)
    }
    
    func removeItem(pantryItem: PantryItem) {
        if pantryItem.isInShoppingList {
            pantryItem.isInPantry = false
        } else {
            context.delete(pantryItem)
        }
    }
}
