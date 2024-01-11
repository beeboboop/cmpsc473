//
//  RecipeStep.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import Foundation

struct RecipeStep : Decodable, DetailCardProtocol {
    let number : Int
    let step : String
    var ingredients : [Ingredient]
    let equipment : [Equipment]
    let length : StepLength?
    
    enum CodingKeys : String, CodingKey {
        case number, step, ingredients, equipment, length
    }
    
    var id : Int {
        self.number
    }
    
    var displayName: String {
        self.step
    }
    var bulletStyle: String {
        "\(self.number).\t"
    }
}
