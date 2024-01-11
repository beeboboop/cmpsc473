//
//  RequestBuilder.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/6/23.
//

import Foundation

extension Manager {
    func buildRequest(type: RequestType, recipeId : Int?) -> String {
        var typeString : String = ""
        var baseRequest = "https://api.spoonacular.com/recipes/\(typeString)?apiKey=\(Constants.apiKey)"
        return baseRequest
    }
}
