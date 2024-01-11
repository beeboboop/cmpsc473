//
//  PantryItem.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import Foundation
import SwiftData

@Model
class PantryItem : Identifiable {
    let name : String
    let itemDescription : String
    var pantryAmount : Int = 0
    var shoppingAmount : Int = 0
    var isInShoppingList : Bool = false
    var isInPantry : Bool = false
    var hasBeenBought : Bool = false
    var hasBeenSaved : Bool = false
    var id : UUID = UUID()
    
    init(name: String, itemDescription: String, pantryAmount: Int, shoppingAmount: Int, 
         isInShoppingList: Bool, isInPantry: Bool) {
        self.name = name
        self.itemDescription = itemDescription
        self.pantryAmount = pantryAmount
        self.shoppingAmount = shoppingAmount
        self.isInShoppingList = isInShoppingList
        self.isInPantry = isInPantry
    }
}

extension PantryItem {
    convenience init(pantryItem: PantryItem) {
        self.init(name: pantryItem.name, 
                  itemDescription: pantryItem.itemDescription,
                  pantryAmount: pantryItem.pantryAmount, 
                  shoppingAmount: pantryItem.shoppingAmount,
                  isInShoppingList: pantryItem.isInShoppingList, 
                  isInPantry: pantryItem.isInPantry)
    }
}

extension PantryItem : Equatable {
    static func == (lhs: PantryItem, rhs: PantryItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension PantryItem {
    static let standard = PantryItem(name: "Green Beans", itemDescription: "Green Giant", pantryAmount: 5, shoppingAmount: 2,
                                     isInShoppingList: true, isInPantry: true)
}
