//
//  Manager+UIKit.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import Foundation

extension RecipeManager {
    func imageForRecipe(_ recipe: Recipe) async {
        guard let url = URL(string: recipe.image) else {return}
        do {
            let (data,_) = try await URLSession.shared.data(from:url)
            DispatchQueue.main.async {
                recipe.imageData = data
            }
        } catch {
            print(error)
        }
    }
    
    func detailsForRecipes(_ recipeIds: Set<Int>) async {
        guard let url = recipeDetailsBulkUrl(recipeIds: recipeIds.shuffled()) else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": Constants.apiKey,
        ]
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            let recipes = recipesFrom(data, responseType: ResponseBInformation.self)
            if let httpResponse = response as? HTTPURLResponse {
                ensureRemainingCredits(httpResponse: httpResponse)
            }
            self.favoritedRecipes.append(contentsOf: recipes)
            for recipe in recipes {
                Task {
                    await imageForRecipe(recipe)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func detailsForRecipe(_ recipe: Recipe) async {
        guard let url = recipeDetailsUrl(recipe: recipe) else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": Constants.apiKey,
        ]
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            if let retrievedRecipe = recipeFrom(data, responseType: ResponseInformation.self) {
                recipe.recipeDetails = retrievedRecipe.recipeDetails
            }
            if let httpResponse = response as? HTTPURLResponse {
                ensureRemainingCredits(httpResponse: httpResponse)
            }
        } catch {
            print(error)
        }
    }
    
    func complexSearch(number: Int, queryParameters params: QueryParameters) async {
        guard let url = complexSearchUrl(number: number, queryParams: params) else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": Constants.apiKey,
        ]
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            let recipes = recipesFrom(data, responseType: ResponseSearch.self)
            if let httpResponse = response as? HTTPURLResponse {
                ensureRemainingCredits(httpResponse: httpResponse)
            }
            self.searchResults.append(contentsOf: recipes)
            for recipe in recipes {
                Task {
                    await imageForRecipe(recipe)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func fetchCuisineRow(cuisine: Cuisine) async {
        let params = QueryParameters(cuisines: [cuisine], sortBy: .random)
        guard let url = complexSearchUrl(number: self.homeRowSize, queryParams: params) else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": Constants.apiKey,
        ]
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            let recipes = recipesFrom(data, responseType: ResponseSearch.self)
            if let httpResponse = response as? HTTPURLResponse {
                ensureRemainingCredits(httpResponse: httpResponse)
            }
            self.homeSections[sectionIndex(cuisine: cuisine)].recipes = recipes
            for recipe in recipes {
                Task {
                    await imageForRecipe(recipe)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func fetchDietRow(diet: Diet) async {
        let params = QueryParameters(diets: [diet], sortBy: .random)
        guard let url = complexSearchUrl(number: self.homeRowSize, queryParams: params) else {return}
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "X-RapidAPI-Key": Constants.apiKey,
        ]
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            let recipes = recipesFrom(data, responseType: ResponseSearch.self)
            if let httpResponse = response as? HTTPURLResponse {
                ensureRemainingCredits(httpResponse: httpResponse)
            }
            self.homeSections[sectionIndex(diet: diet)].recipes = recipes
            for recipe in recipes {
                Task {
                    await imageForRecipe(recipe)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    func recipesFrom<T:ApiResponseBulk>(_ data: Data, responseType: T.Type) -> [Recipe] {
        var recipes : [Recipe]
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(T.self, from: data)
            recipes = response.results
        } catch {
            print(error)
            print(String(data: data, encoding: .utf8) ?? "")
            recipes = []
        }
        return recipes
    }
    
    func recipeFrom<T:ApiResponse>(_ data: Data, responseType: T.Type) -> Recipe? {
        var recipe : Recipe
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(T.self, from: data)
            recipe = response.result
        } catch {
            print(error)
            return nil
        }
        return recipe
    }
    
    func ensureRemainingCredits(httpResponse: HTTPURLResponse) {
        let headers = httpResponse.allHeaderFields
        if let remainingRequests = headers["x-ratelimit-requests-remaining"] as? String {
            let _remainingRequests = Int(remainingRequests) ?? -1
            assert(_remainingRequests > 0)
        }
        if let remainingTinyRequests = headers["x-ratelimit-tinyrequests-remaining"] as? String {
            let _remainingTinyRequests = Int(remainingTinyRequests) ?? -1
            assert(_remainingTinyRequests > 0)
        }
        if let remainingResults = headers["x-ratelimit-results-remaining"] as? String {
            let _remainingResults = Int(remainingResults) ?? -1
            assert(_remainingResults > 0)
        }
    }
}
