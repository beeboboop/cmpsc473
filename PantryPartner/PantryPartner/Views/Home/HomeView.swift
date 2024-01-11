//
//  HomeView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(RecipeManager.self) var manager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        if !manager.favoritedRecipes.isEmpty {
                            HomeRow(recipes: manager.favoritedRecipes,
                                    cuisine: nil,
                                    diet: nil)
                        }
                        ForEach(manager.homeSections) {section in
                            if let cuisine = section.cuisine {
                                HomeRow(recipes: section.recipes,
                                        cuisine: cuisine,
                                        diet: nil)
                            } else if let diet = section.diet {
                                HomeRow(recipes: section.recipes,
                                        cuisine: nil,
                                        diet: diet)
                                
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}
