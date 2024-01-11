//
//  StartCookingButton.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import SwiftUI

struct StartCookingButton: View {
    let steps: [RecipeStep]
    let details : RecipeDetails
    
    var body: some View {
        NavigationLink(destination: CookingModeView(steps: steps, details: details)) {
            Text("Start Cooking")
                .font(.subheadline)
                .foregroundStyle(.white)
                .padding([.horizontal], 7)
                .padding([.vertical], 3)
                .background {
                    Capsule()
                        .fill(Color.orangeButton)
                }
        }
    }
}
