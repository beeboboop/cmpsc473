//
//  Recipe.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/2/23.
//

import Foundation

@Observable
class Recipe : Decodable, Identifiable, Equatable {
    let id : Int
    let recipeName : String
    let image : String
    var imageData : Data? = nil
    var recipeDetails : RecipeDetails? = nil
    
    init(id: Int, title: String, image: String, servings: Int, readyInMinutes: Int, preparationMinutes: Int, cookingMinutes: Int, pricePerServing: Double, summary: String, cuisines: [String], dishTypes: [String], diets: [String], instructionSummary: String, instructions: [RecipeStep], ingredients: [Ingredient], creditsText: String, sourceUrl: String, nutrition: Nutrition) {
        self.id = id
        self.recipeName = title
        self.image = image
        self.recipeDetails = RecipeDetails(servings: servings, readyInMinutes: readyInMinutes, preparationMinutes: preparationMinutes, cookingMinutes: cookingMinutes, pricePerServing: pricePerServing, summary: summary, cuisines: cuisines, dishTypes: dishTypes, diets: diets, instructions: instructionSummary, sourceUrl: sourceUrl, creditsText: creditsText, analyzedInstructions: [AnalyzedInstructions(name: "", steps: instructions)], extendedIngredients: ingredients, nutrition: nutrition)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.recipeName = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
        let servings = try container.decodeIfPresent(Int.self, forKey: .servings)
        let readyInMinutes = try container.decodeIfPresent(Int.self, forKey: .readyInMinutes)
        let preparationMinutes = try container.decodeIfPresent(Int.self, forKey: .preparationMinutes)
        let cookingMinutes = try container.decodeIfPresent(Int.self, forKey: .cookingMinutes)
        let pricePerServing = try container.decodeIfPresent(Double.self, forKey: .pricePerServing)
        let summary = try container.decodeIfPresent(String.self, forKey: .summary)
        let cuisines = try container.decodeIfPresent([String].self, forKey: .cuisines)
        let dishTypes = try container.decodeIfPresent([String].self, forKey: .dishTypes)
        let diets = try container.decodeIfPresent([String].self, forKey: .diets)
        let instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        let analyzedInstructions = try container.decodeIfPresent([AnalyzedInstructions].self, forKey: .analyzedInstructions)
        let extendedIngredients = try container.decodeIfPresent([Ingredient].self, forKey: .extendedIngredients)
        let sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        let creditsText = try container.decodeIfPresent(String.self, forKey: .creditsText)
        let nutrition = try container.decodeIfPresent(Nutrition.self, forKey: .nutrition)
        if let servings, let readyInMinutes, let preparationMinutes, let cookingMinutes,
            let summary, let cuisines, let dishTypes, let diets, let instructions,
            let analyzedInstructions, let extendedIngredients, let pricePerServing,
            let sourceUrl, let creditsText, let nutrition {
            self.recipeDetails = RecipeDetails (servings: servings, readyInMinutes: readyInMinutes, preparationMinutes: preparationMinutes, cookingMinutes: cookingMinutes, pricePerServing: pricePerServing, summary: summary, cuisines: cuisines, dishTypes: dishTypes, diets: diets, instructions: instructions, sourceUrl: sourceUrl, creditsText: creditsText, analyzedInstructions: analyzedInstructions, extendedIngredients: extendedIngredients, nutrition: nutrition)
        }
    }
    
    enum CodingKeys : CodingKey {
        case id, title, image, servings
        case readyInMinutes, preparationMinutes, cookingMinutes
        case summary, cuisines, dishTypes
        case diets, instructions, analyzedInstructions
        case extendedIngredients, pricePerServing
        case sourceUrl, creditsText, nutrition
    }
}

extension Recipe {
    var title : String {
        recipeName.localizedCapitalized
    }
    
    static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Recipe {
    static let standard = Recipe(id: 632935,
                                 title: "Asparagus Lemon Risotto",
                                 image: "https://spoonacular.com/recipeImages/579247-556x370.jpg",
                                 servings: 4,
                                 readyInMinutes: 45,
                                 preparationMinutes: -1,
                                 cookingMinutes: -1,
                                 pricePerServing: 106.38,
                                 summary: "If you want to add more <b>Mediterranean</b> recipes to your collection, Asparagus Lemon Risotto might be a recipe you should try. This main course has <b>609 calories</b>, <b>16g of protein</b>, and <b>6g of fat</b> per serving. This recipe serves 4. For <b>$3.9 per serving</b>, this recipe <b>covers 34%</b> of your daily requirements of vitamins and minerals. 5 people have tried and liked this recipe. A mixture of peas, parmesan cheese, pepper, and a handful of other ingredients are all it takes to make this recipe so scrumptious. It is brought to you by Foodista. It is a good option if you're following a <b>gluten free</b> diet. From preparation to the plate, this recipe takes around <b>45 minutes</b>. All things considered, we decided this recipe <b>deserves a spoonacular score of 88%</b>. This score is tremendous. If you like this recipe, you might also like recipes such as <a href=\"https://spoonacular.com/recipes/asparagus-and-lemon-risotto-498928\">Asparagus and Lemon Risotto</a>, <a href=\"https://spoonacular.com/recipes/asparagus-lemon-risotto-604880\">Asparagus Lemon Risotto</a>, and <a href=\"https://spoonacular.com/recipes/lemon-risotto-with-asparagus-36424\">Lemon Risotto with Asparagus</a>.",
                                 cuisines: ["Mediterranenan", "Italian", "European"],
                                 dishTypes: ["side dish", "lunch", "main course", "main dish", "dinner"],
                                 diets: ["gluten free"],
                                 instructionSummary: "In a large saucepan, combine broth and water. Bring to a simmer. Keep warm over low heat.\nHeat oil in a large Dutch oven over medium heat. Add onion; saute 5 minutes or until tender. Add garlic; saute 30 seconds. Add rice; cook 2 minutes, stirring constantly. Stir in wine; cook 2 minutes or until liquid is nearly absorbed, stirring constantly. Mix in pepper. Add broth mixture, 1/2 cup at a time, stirring constantly, cook until each portion of broth is absorbed before adding the next (about 25 minutes). Add asparagus, and frozen peas,  during the last 10 minutes of cooking. Remove from heat; stir in cheese and remaining ingredients.\nT(Cooking):\"0:40\"\nNOTES :",
                                 instructions: [
                                    RecipeStep(number: 1, step: "In a large saucepan, combine broth and water. Bring to a simmer. Keep warm over low heat.", ingredients: [Ingredient(spoonacularId: 1006615, name: "broth", originalName: nil, image: "chicken-broth.png", amount: nil, unit: nil), Ingredient(spoonacularId: 14412, name: "water", originalName: nil, image: "water.png", amount: nil, unit: nil)], equipment: [Equipment(id: 404669, name: "sauce pan", image: "sauce-pan.jpg", temperature: nil)], length: nil),
                                    RecipeStep(number: 2, step: "Heat oil in a large Dutch oven over medium heat.", ingredients: [Ingredient(spoonacularId: 4582, name: "cooking oil", originalName: nil, image: "vegetable-oil.jpg", amount: nil, unit: nil)], equipment: [Equipment(id: 404667, name: "dutch oven", image: "dutch-oven.jpg", temperature: nil)], length: nil),
                                    RecipeStep(number: 3, step: "Add onion; saute 5 minutes or until tender", ingredients: [Ingredient(spoonacularId: 11282, name: "onion", originalName: nil, image: "brown-onion.png", amount: nil, unit: nil)], equipment: [], length: StepLength(number: 5, unit: "minutes")),
                                 ],
                                 ingredients: [Ingredient(spoonacularId: 6615, name: "vegetable broth", originalName: nil, image: "chicken-broth.png", amount: 29.0, unit: "oz"), Ingredient(spoonacularId: 14412, name: "water", originalName: nil, image: "water.png", amount: 2.5, unit: "cups"), Ingredient(spoonacularId: 4053, name: "olive oil", originalName: nil, image: "olive-oil.jpg", amount: 1.0, unit: "tablespoon"), Ingredient(spoonacularId: 11282, name: "onion", originalName: nil, image: "brown-onion.png", amount: 1.0, unit: "cup"), Ingredient(spoonacularId: 11215, name: "garlic", originalName: nil, image: "garlic.png", amount: 3.0, unit: "cloves"), Ingredient(spoonacularId: 10020052, name: "arborio rice", originalName: nil, image: "arborio-rice.png", amount: 1.5, unit: "cups"), Ingredient(spoonacularId: 14106, name: "wine", originalName: nil, image: "white-wine.jpg", amount: 0.5, unit: "cup"), Ingredient(spoonacularId: 1002030, name: "pepper", originalName: nil, image: "pepper.jpg", amount: 0.25, unit: "teaspoon"), Ingredient(spoonacularId: 11011, name: "asparagus", originalName: nil, image: "asparagus.png", amount: 1.5, unit: "pounds"), Ingredient(spoonacularId: 11304, name: "peas", originalName: nil, image: "peas.jpg", amount: 0.5, unit: "cup"), Ingredient(spoonacularId: 1033, name: "parmesan cheese", originalName: nil, image: "parmesan.jpg", amount: 0.25, unit: "cup")],
                                 creditsText: "Foodista the food library",
                                 sourceUrl: "testurl.com",
                                 nutrition: Nutrition(nutrients: [Nutrient(name: "Calories", amount: 576.3, unit: "kcal", percentOfDailyNeeds: 27.8)])
                                 )
}
