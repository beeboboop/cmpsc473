//
//  Manager + SearchView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import Foundation

//Search View Functions
extension RecipeManager {
    var areFiltersNotApplied : Bool {
        return searchParameters.cuisines.isEmpty && searchParameters.diets.isEmpty &&
            searchParameters.intolerances.isEmpty && searchParameters.dishTypes.isEmpty &&
            searchParameters.includeIngredients == false && searchParameters.ignorePantryStaples == false &&
            searchParameters.sortBy == .popularity
    }
    
    func clearResults() {
        searchResults.removeAll()
    }
    
    func clearQuery() {
        searchParameters = QueryParameters()
    }
    
    func toggleSearchParam<T:FilterEnumProtocol>(foodEnum : T) {
        switch foodEnum {
        case is Cuisine: 
            toggleSearchParam(cuisine: foodEnum as! Cuisine)
        case is Diet: 
            toggleSearchParam(diet: foodEnum as! Diet)
        case is Intolerance: 
            toggleSearchParam(intolerance: foodEnum as! Intolerance)
        case is DishType: 
            toggleSearchParam(mealType: foodEnum as! DishType)
        default: 
            fatalError("Invalid search parameter")
        }
    }
    
    func toggleSearchParam(cuisine: Cuisine) {
        if searchParameters.cuisines.contains(cuisine) {
            searchParameters.cuisines.removeAll(where: {$0 == cuisine})
        } else {
            searchParameters.cuisines.append(cuisine)
        }
    }
    
    func toggleSearchParam(diet: Diet) {
        if searchParameters.diets.contains(diet) {
            searchParameters.diets.removeAll(where: {$0 == diet})
        } else {
            searchParameters.diets.append(diet)
        }
    }
    
    func toggleSearchParam(intolerance: Intolerance) {
        if searchParameters.intolerances.contains(intolerance) {
            searchParameters.intolerances.removeAll(where: {$0 == intolerance})
        } else {
            searchParameters.intolerances.append(intolerance)
        }
    }
    
    func toggleSearchParam(mealType: DishType) {
        if searchParameters.dishTypes.contains(mealType) {
            searchParameters.dishTypes.removeAll(where: {$0 == mealType})
        } else {
            searchParameters.dishTypes.append(mealType)
        }
    }
    
    func searchParametersContain<T:FilterEnumProtocol>(_ foodEnum : T) -> Bool {
        switch foodEnum {
        case is Cuisine:
            return searchParameters.cuisines.contains(foodEnum as! Cuisine)
        case is Diet:
            return searchParameters.diets.contains(foodEnum as! Diet)
        case is Intolerance:
            return searchParameters.intolerances.contains(foodEnum as! Intolerance)
        case is DishType:
            return searchParameters.dishTypes.contains(foodEnum as! DishType)
        default:
            return false
        }
    }
}
