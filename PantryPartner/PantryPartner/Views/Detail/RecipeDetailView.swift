//
//  RecipeDetailView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/6/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Environment(RecipeManager.self) var manager
    @State private var lineLimit : Int = 5
    @State private var isShowingInfo : Bool = false
    
    let recipe : Recipe
    
    var body: some View {
        NavigationStack { 
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        RecipeImage(recipe: recipe)
                        if let details = recipe.recipeDetails {
                            RecipeSummary(strippedSummary: details.strippedHtmlSummary,
                                          lineLimit: $lineLimit)
                        }
                    }
                    Spacer()
                    if let details = recipe.recipeDetails {
                            DetailCardStack(recipe: recipe, details: details)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                
                }
            }
            .navigationTitle(recipe.title)
            .toolbar {
                if let details = recipe.recipeDetails, let steps = recipe.recipeDetails?.analyzedInstructions.first?.steps {
                    ToolbarItem(placement: .topBarTrailing) {
                        StartCookingButton(steps: steps, details: details)
                            .opacity(recipe.recipeDetails == nil ? 0.5 : 1)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {isShowingInfo = true}) {
                            Image(systemName: "info.circle")
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: lineLimit)
        .sheet(isPresented: $isShowingInfo) {
            InfoView(recipe: recipe,
                     isExpanded: $isShowingInfo)
        }
        .onAppear {
            if recipe.recipeDetails == nil {
                Task {
                    await manager.detailsForRecipe(recipe)
                }
            }
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.standard)
        .environment(RecipeManager())
}
