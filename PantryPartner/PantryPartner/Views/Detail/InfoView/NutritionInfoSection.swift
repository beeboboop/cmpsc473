//
//  NutritionInfoSection.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct NutritionInfoSection: View {
    let details: RecipeDetails
    @State private var isShowingNutrition : Bool = false
    
    var nutrientImageName : String {
        isShowingNutrition ? "chevron.up" : "chevron.down"
    }
    
    var body: some View {
        HStack {
            Text("Nutrition Info")
                .font(.title2)
            Text("(per serving)")
                .font(.subheadline)
                .foregroundStyle(.gray)
            Spacer()
            Image(systemName: nutrientImageName)
                .foregroundStyle(.gray)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isShowingNutrition.toggle()
        }
        if isShowingNutrition {
            Grid(alignment: .leading) {
                GridRow {
                    Text("Nutrient")
                    Spacer()
                    Text("Amount")
                    Spacer()
                    Text("Percent of Daily")
                }
                .font(.caption)
                .bold()
                ForEach(details.nutrition.nutrients) { nutrient in
                    Divider()
                    GridRow {
                        Text(nutrient.name)
                        Spacer()
                        Text(nutrient.amountString)
                        Spacer()
                        Text(nutrient.percentString)
                    }
                    .font(.caption2)
                }
            }
        }
    }
}
