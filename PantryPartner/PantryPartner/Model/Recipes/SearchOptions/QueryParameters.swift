//
//  QueryParameters.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/18/23.
//

import Foundation

struct QueryParameters {
    var query : String = ""
    var cuisines : [Cuisine] = []
    var diets : [Diet] = []
    var intolerances : [Intolerance] = []
    var dishTypes : [DishType] = []
    var sortBy : SortOption = .popularity
    var includeIngredients : Bool = false
    var ignorePantryStaples : Bool = false
    var ingredients : [PantryItem] = []
    var offset : Int = 0
    
    var queryIngredients : [PantryItem] {
        includeIngredients ? ingredients : []
    }
}
