//
//  Diet.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation

enum Diet : String, FilterEnumProtocol {
    case glutenFree = "gluten free", ketogenic, vegetarian, lactoVegetarian = "lacto vegetarian", ovoVegetarian = "ovo vegetarian"
    case vegan, pescetarian, paleo, primal, lowFodmap = "low fodmap", whole30
    
    var sectionTitle : String {
        switch self {
        case .glutenFree: return "Gluten-Free Goodies"
        case .ketogenic: return "Keto Wonders"
        case .vegetarian: return "Vegetarian Delights"
        case .lactoVegetarian: return "Lacto-Vegetarian Choices"
        case .ovoVegetarian: return "Ovo-Vegetarian Selections"
        case .vegan: return "Vegan Treats"
        case .pescetarian: return "Pescetarian Plates"
        case .paleo: return "Paleo Pleasures"
        case .primal: return "Primal Provisions"
        case .lowFodmap: return "Low FODMAP Options"
        case .whole30: return "Whole30 Feasts"
        }
    }
    
    var id : Self {
        return self
    }
}
