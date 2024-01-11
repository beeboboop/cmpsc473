//
//  ShoppingTemplate.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import Foundation
import SwiftData

@Model
class ShoppingTemplate : Identifiable {
    let name : String
    var items : [PantryItem]
    
    var id : String {
        self.name
    }
    
    var count : Int {
        self.items.count
    }
    
    init(name: String, items: [PantryItem]) {
        self.name = name
        self.items = items
    }
}

extension ShoppingTemplate {
    static let standard = ShoppingTemplate(name: "Standard Template", items: [PantryItem.standard, PantryItem.standard, PantryItem.standard])
}
