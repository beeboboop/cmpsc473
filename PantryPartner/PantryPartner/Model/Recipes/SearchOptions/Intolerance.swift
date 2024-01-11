//
//  Intolerance.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation

enum Intolerance : String, FilterEnumProtocol {
    case dairy, egg, gluten, grain, peanut, seafood
    case sesame, shellfish, soy, sulfite, treeNut = "tree nut", wheat
    
    var id : Self {
        return self
    }
}
