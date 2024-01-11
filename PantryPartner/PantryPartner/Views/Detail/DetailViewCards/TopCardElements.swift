//
//  RecipeStats.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI

struct ServingsStepper: View {
    @Environment(RecipeManager.self) var manager
    
    let recipe : Recipe
    let details : RecipeDetails
    var body: some View {
        VStack {
            Text("Servings")
                .font(.title3)
            HStack {
                Button(action: {manager.decrementServings(recipe: recipe)}) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(.orangeButton)
                        .disabled(recipe.recipeDetails!.servings <= 1)
                }
                Text("\(details.servings)")
                    .fontDesign(.monospaced)
                Button(action: {manager.incrementServings(recipe: recipe)}) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.orangeButton)
                }
            }
        }
    }
}

struct RecipeStats: View {
    let details : RecipeDetails
    
    var body: some View {
        VStack {
            Text("Ready In")
                .font(.title3)
            Text("\(details.readyInMinutes) mins")
        }
        Spacer()
        VStack {
            Text("Cost/Serving")
                .font(.title3)
            Text("\(details.priceString)")
        }
    }
}
