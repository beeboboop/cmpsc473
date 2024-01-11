//
//  FoodCardRow.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/6/23.
//

import SwiftUI
//TODO: Refactor using polymporphism

struct HomeRow: View {
    @Environment(RecipeManager.self) var manager
    var recipes : [Recipe]?
    let cuisine : Cuisine?
    let diet : Diet?
    
    var sectionTitle : String {
        if let cuisine {
            return cuisine.sectionTitle
        } else if let diet {
            return diet.sectionTitle
        } else {
            return "Your Favorites"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sectionTitle)
                .font(.title)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    if let recipes {
                        ForEach(recipes) {recipe in
                            FoodCard(recipe: recipe)
                                .padding(.horizontal)
                        }
                    } else {
                        ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                        .onAppear {
                            if let cuisine {
                                Task {
                                    await manager.fetchCuisineRow(cuisine: cuisine)
                                }
                            } else if let diet {
                                Task {
                                    await manager.fetchDietRow(diet: diet)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

