//
//  Manager + DetailView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import Foundation

//Detail View Functions
extension RecipeManager {
    func incrementServings(recipe: Recipe) {
        if recipe.recipeDetails != nil {
            let old = recipe.recipeDetails!.servings
            recipe.recipeDetails!.servings += 1
            
            let ratio = Double(recipe.recipeDetails!.servings) / Double(old)
            
            updateAmounts(recipe: recipe, ratio: ratio)
        }
    }
    
    func decrementServings(recipe: Recipe) {
        if recipe.recipeDetails != nil && recipe.recipeDetails!.servings > 1 {
            let old = recipe.recipeDetails!.servings
            recipe.recipeDetails!.servings -= 1
            
            let ratio = Double(recipe.recipeDetails!.servings) / Double(old)
            
            updateAmounts(recipe: recipe, ratio: ratio)
        }
    }
    
    func updateAmounts(recipe: Recipe, ratio: Double) {
        //Very ugly but necessary without turning everything into an Observable object
        if recipe.recipeDetails!.analyzedInstructions.first?.steps != nil {
            for stepIndex in recipe.recipeDetails!.analyzedInstructions[0].steps.indices {
                for ingredientIndex in recipe.recipeDetails!.analyzedInstructions[0].steps[stepIndex].ingredients.indices {
                    if recipe.recipeDetails!.analyzedInstructions[0].steps[stepIndex].ingredients[ingredientIndex].amount != nil{
                        recipe.recipeDetails!.analyzedInstructions[0].steps[stepIndex].ingredients[ingredientIndex].amount! *= ratio
                    }
                }
            }
        }
        
        for ingredientIndex in recipe.recipeDetails!.extendedIngredients.indices {
            if recipe.recipeDetails!.extendedIngredients[ingredientIndex].amount != nil{
                 recipe.recipeDetails!.extendedIngredients[ingredientIndex].amount! *= ratio
            }
        }
    }
    
    func secondsFrom(interval: Int, unit: String) -> Int {
        switch unit {
        case "hour", "hr", "hours", "hrs" :
            return interval * 3600
        case "min", "minute", "mins", "minutes" :
            return interval * 60
        default :
            return interval
        }
    }
    
    func secondsFormatted(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter.string(from: TimeInterval(seconds)) ?? ""
    }
    
}
