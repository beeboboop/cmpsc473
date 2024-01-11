//
//  Manager.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import Foundation

@Observable
class RecipeManager {
    var homeSections : [HomeSection] = []
    var searchResults : [Recipe] = []
    var favoritedRecipes : [Recipe] = []
    var searchParameters : QueryParameters = QueryParameters()
    var user : User
    let persister : Persister
    
    //LIVE
    let numResults : Int = 8
    let homeRowSize : Int = 5
    
    //DEBUG
    //let numResults : Int = 1
    //let homeRowSize : Int = 1
    
    init() {
        persister = Persister(fileName: "user")
        user = persister.user
        if !user.favoriteRecipes.isEmpty {
            Task {
                await self.detailsForRecipes(self.user.favoriteRecipes)
            }
        }
        
        //LIVE
        homeSections.append(contentsOf:
                                Cuisine.allCases.map {HomeSection(recipes: nil, cuisine: $0, diet: nil)}
                            )
        homeSections.append(contentsOf:
                                Diet.allCases.map {HomeSection(recipes: nil, cuisine: nil, diet: $0)}
                            )
        homeSections = homeSections.shuffled()
        
        
        //DEBUG
        //homeSections = [HomeSection(recipes: nil, cuisine: .african, diet: nil), HomeSection(recipes: nil, cuisine: nil, diet: .glutenFree)]
    }
}

extension RecipeManager {
    func toggleFavoriteOf(_ recipe: Recipe) {
        if isRecipeFavorited(recipe) {
            self.user.favoriteRecipes.remove(recipe.id)
            self.favoritedRecipes.removeAll(where: {$0.id == recipe.id})
        } else {
            self.user.favoriteRecipes.insert(recipe.id)
            self.favoritedRecipes.append(recipe)
        }
    }
    
    func isRecipeFavorited(_ recipe: Recipe) -> Bool {
        return self.user.favoriteRecipes.contains(recipe.id)
    }
}
