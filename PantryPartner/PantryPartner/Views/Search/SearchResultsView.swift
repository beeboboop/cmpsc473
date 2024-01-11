//
//  SearchResultsView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/18/23.
//

import SwiftUI

struct SearchResultsView: View {
    @Environment(RecipeManager.self) var manager
    let columns = [GridItem(.adaptive(minimum: 175))]
    
    let number : Int
    @Binding var queryParameters : QueryParameters
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(manager.searchResults) { recipe in
                        FoodCard(recipe: recipe)
                    }
                }
                Button(action: {
                    queryParameters.offset += number
                    Task {
                        await manager.complexSearch(number: number,
                                              queryParameters: queryParameters)
                    }
                }) {
                    Text("Load More Recipes")
                }
                .padding()
            }
        }
    }
}
