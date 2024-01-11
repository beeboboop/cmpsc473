//
//  User.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/2/23.
//

import Foundation

struct User : Codable {
    var favoriteRecipes : Set<Int> = []
    var intolerances : [Intolerance] = []
    var diet : [Diet] = []
}

