//
//  UrlBuilder.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/8/23.
//

import Foundation

extension RecipeManager {
    func complexSearchUrl(number: Int, queryParams params: QueryParameters) -> URL? {
        var url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?"
        let query = "query=\(params.query)&"
        let intolerances = "intolerances=" + params.intolerances.map({$0.rawValue}).joined(separator: ",") + "&"
        let diets = "diet=" + params.diets.map({$0.rawValue}).joined(separator: ",") + "&"
        let cuisines = "cuisine=" + params.cuisines.map({$0.rawValue}).joined(separator: ",") + "&"
        let types = "type=" + params.dishTypes.map({$0.rawValue}).joined(separator: ",") + "&"
        let ingredients = "includeIngredients=" + params.queryIngredients.map({$0.name}).joined(separator: ",") + "&"
        let ignorePantry = "ignorePantry=\(params.ignorePantryStaples ? "true" : "false")&"
        let number = "number=\(number)&"
        let instructions = "instructionsRequired=true&"
        let sort = "sort=" + params.sortBy.rawValue + "&"
        let offset = "offset=\(params.offset)&"
        url += query + intolerances + diets + cuisines + types + ingredients + ignorePantry + number + instructions + sort + offset
        return URL(string: url)
    }
    
    func recipeDetailsUrl(recipe: Recipe) -> URL? {
        let url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/\(recipe.id)/information?includeNutrition=true"
        return URL(string: url)
    }
    
    func recipeDetailsBulkUrl(recipeIds: [Int]) -> URL? {
        let idString = "ids=" + recipeIds.map({String($0)}).joined(separator: ",") + "&"
        let url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/informationBulk?\(idString)includeNutrition=true"
        return URL(string: url)
        
    }
}
