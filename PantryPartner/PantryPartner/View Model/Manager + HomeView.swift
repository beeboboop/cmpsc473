//
//  Manager + HomeView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import Foundation

//Home View Functions
extension RecipeManager {
    func sectionIndex(cuisine: Cuisine) -> Int {
        homeSections.firstIndex(where: {$0.cuisine == cuisine})!
    }
    
    func sectionIndex(diet: Diet) -> Int {
        homeSections.firstIndex(where: {$0.diet == diet})!
    }
}
