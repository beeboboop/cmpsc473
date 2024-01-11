//
//  TemplateTile.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct TemplateTile: View {
    @Environment(\.modelContext) var context
    
    let template : ShoppingTemplate
    @State private var isEditing : Bool = false
    @State private var isAddedToShoppingList : Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.background2)
            if isAddedToShoppingList {
                Image(systemName: "checkmark")
                    .foregroundStyle(.mint)
                    .scaleEffect(1.75)
                    .offset(x: 55, y: -55)
            }
            VStack {
                Text(template.name)
                    .font(.title3)
                    .lineLimit(2)
                Text("\(template.count) items")
                    .foregroundStyle(.gray)
                HStack {
                    Spacer()
                    IconButton(imageName: "cart.circle.fill",
                               backgroundColor: .mint,
                               action: addItemsToList)
                    Spacer()
                    IconButton(imageName: "pencil.circle.fill",
                               backgroundColor: .orangeButton,
                               action: {isEditing.toggle()})
                    Spacer()
                    IconButton(imageName: "trash.circle.fill",
                               backgroundColor: .red, 
                               action: removeTemplate)
                    Spacer()
                }
                .scaleEffect(1.33)
            }
            .padding(.horizontal)
        }
        .animation(.easeInOut, value: isAddedToShoppingList)
        .sheet(isPresented: $isEditing) {
            EditTemplateView(template: template)
        }
        .frame(width: 150, height: 150)
    }
}

extension TemplateTile {
    func removeTemplate() {
        context.delete(template)
    }
    
    func addItemsToList() {
        isAddedToShoppingList = true
        for pantryItem in template.items {
            let newItem = PantryItem(pantryItem: pantryItem)
            newItem.isInShoppingList = true
            context.insert(newItem)
        }
    }
}
