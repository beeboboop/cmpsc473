//
//  DetailCardStack.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI

struct DetailCardStack: View {
    let recipe : Recipe
    let details : RecipeDetails
    @State private var ingredientsExpanded : Bool = false
    @State private var instructionsExpanded : Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            TopDetailCard(recipe: recipe, details: details)
            DetailCard(title: "Ingredients",
                       details: details.extendedIngredients,
                       isExpanded: $ingredientsExpanded,
                       color: Color.background2)
            .frame(maxHeight: 60)
            .padding(.top, 90)
            .fullScreenCover(isPresented: $ingredientsExpanded) {
                DetailCard(title: "Ingredients",
                           details: details.extendedIngredients,
                           isExpanded: $ingredientsExpanded,
                           color: Color.background2)
            }
            if let steps = details.analyzedInstructions.first?.steps {
                DetailCard(title: "Instructions",
                           details: steps,
                           isExpanded: $instructionsExpanded,
                           color: Color.background3)
                .frame(maxHeight: 60)
                .padding(.top, 150)
                .fullScreenCover(isPresented: $instructionsExpanded) {
                    DetailCard(title: "Instructions",
                               details: steps,
                               isExpanded: $instructionsExpanded,
                               color: Color.background3)
                }
            }
        }
    }
}
