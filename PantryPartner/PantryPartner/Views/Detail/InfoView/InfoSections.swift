//
//  InfoSections.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct InfoSections: View {
    let details: RecipeDetails
    @State private var isShowingNutrition : Bool = false
    
    var nutrientImageName : String {
        isShowingNutrition ? "chevron.up" : "chevron.down"
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if !details.cuisines.isEmpty {
                InfoSection(title: "Cuisines",
                            text: details.cuisines.joined(separator: ", ").localizedCapitalized)
                Divider()
            }
            if !details.diets.isEmpty {
                InfoSection(title: "Diets",
                            text: details.diets.joined(separator: ", ").localizedCapitalized)
                Divider()
            }
            if !details.dishTypes.isEmpty {
                InfoSection(title: "Dish Types",
                            text: details.dishTypes.joined(separator: ", ").localizedCapitalized)
                Divider()
            }
            NutritionInfoSection(details: details)
            Divider()
            InfoSection(title: "Recipe Source", text: details.creditsText,
                        url: details.sourceUrl)
        }
    }
}

#Preview {
    InfoSections(details: Recipe.standard.recipeDetails!)
}
