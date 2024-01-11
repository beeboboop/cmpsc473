//
//  InfoView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct InfoView: View {
    let recipe: Recipe
    @Binding var isExpanded : Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(recipe.title)
                    .font(.title)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.trailing)
                Spacer()
                Image(systemName: "chevron.down")
                    .foregroundStyle(.gray)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isExpanded = false
            }
            if let details = recipe.recipeDetails {
                InfoSections(details: details)
            }
        }
        .padding()
        .background(Color.background)
    }
}

#Preview {
    InfoView(recipe: Recipe.standard, isExpanded: .constant(false))
}
