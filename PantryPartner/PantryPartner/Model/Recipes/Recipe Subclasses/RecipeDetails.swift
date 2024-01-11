//
//  RecipeDetails.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation
import SwiftData

struct RecipeDetails : Decodable {
    var servings : Int
    let readyInMinutes : Int
    let preparationMinutes : Int
    let cookingMinutes : Int
    let pricePerServing : Double
    let summary : String
    let cuisines : [String]
    let dishTypes : [String]
    let diets : [String]
    let instructions : String
    let sourceUrl : String
    let creditsText : String
    var analyzedInstructions : [AnalyzedInstructions]
    var extendedIngredients : [Ingredient]
    let nutrition : Nutrition
}

extension RecipeDetails {
    var priceString : String {
        let priceInDollars = self.pricePerServing / 100.0
        return "$" + String(format: "%.2f", priceInDollars)
    }
    
    var strippedHtmlSummary : String {
        return self.summary.replacingOccurrences(of: "<a[^>]+>", with: "", options: .regularExpression)
    }
}
