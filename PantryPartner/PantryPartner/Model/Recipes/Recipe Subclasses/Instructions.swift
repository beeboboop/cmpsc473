//
//  Instructions.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/7/23.
//

import Foundation

struct AnalyzedInstructions : Decodable {
    let name : String
    var steps : [RecipeStep]
}
