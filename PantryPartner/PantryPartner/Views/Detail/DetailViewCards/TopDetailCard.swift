//
//  TopDetailCard.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI

struct TopDetailCard: View {
    let recipe : Recipe
    let details : RecipeDetails
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.background)
                .shadow(radius: 8)
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 1)
                .ignoresSafeArea()
            HStack {
                Spacer()
                ServingsStepper(recipe: recipe, details: details)
                Spacer()
                RecipeStats(details: details)
                Spacer()
            }
            .padding(.top)
        }
    }
}
