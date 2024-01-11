//
//  FoodCard.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/6/23.
//

import SwiftUI
import SwiftData

struct FoodCard: View {
    @Environment(RecipeManager.self) var manager
    @Environment(\.colorScheme) var colorScheme
    
    let recipe : Recipe
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
            VStack {
                if let data = recipe.imageData {
                    if let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    }
                } else {
                    Image("EmptyImage")
                        .resizable()
                        .scaledToFill()
                }
                Text(recipe.title)
                    .lineLimit(2, reservesSpace: true)
                    .font(.subheadline)
                    .padding([.bottom, .leading, .trailing])
            }
            .background(colorScheme == .dark ? .background2 : .white)
            .frame(width: 175, height: 175)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

#Preview {
    FoodCard(recipe: Recipe.standard)
        .environment(RecipeManager())
}
