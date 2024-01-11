//
//  RecipeImage.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI

struct RecipeImage: View {
    @Environment(RecipeManager.self) var manager
    let recipe : Recipe
    
    var heartImageName : String {
        manager.isRecipeFavorited(recipe) ? "heart.fill" : "heart"
    }
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let data = recipe.imageData {
                if let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal)
                        .scaledToFit()
                }
            } else {
                Image("EmptyImage")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal)
                    .scaledToFit()
                    .fixedSize()
            }
            VStack {
                Button(action: {manager.toggleFavoriteOf(recipe)}) {
                    Image(systemName: heartImageName)
                        .foregroundStyle(.white)
                        .background(
                            Circle()
                                .fill(.pink)
                                .scaleEffect(2)
                        )
                }
                .padding(.trailing)
            }
            .padding()
        }
    }
}

#Preview {
    RecipeImage(recipe: Recipe.standard)
        .environment(RecipeManager())
}
