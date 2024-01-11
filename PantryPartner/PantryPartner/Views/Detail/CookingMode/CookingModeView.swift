//
//  CookingModeView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct CookingModeView: View {
    @Environment(\.dismiss) var dismiss
    let recipeSteps : [RecipeStep]
    let details : RecipeDetails
    @State private var elapsedTimes : [Int]
    @State private var isTimerActive : [Bool]
    @State private var ingredientsExpanded : Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(steps: [RecipeStep], details: RecipeDetails) {
        //Need to declare the state variables here otherwise they will be lost when tab pages are redrawn
        self.recipeSteps = steps
        self.details = details
        self._elapsedTimes = State(initialValue: Array(repeating: 0, count: steps.count))
        self._isTimerActive = State(initialValue: Array(repeating: false, count: steps.count))
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {dismiss()}) {
                        Image(systemName: "xmark")
                            .foregroundStyle(.gray)
                            .scaleEffect(1.5)
                    }
                }
                .padding()
                TabView {
                    ForEach(0..<recipeSteps.count, id:\.self) {index in
                        StepView(step: recipeSteps[index], stepCount: recipeSteps.count, elapsedTime: $elapsedTimes[index], isTimerActive: $isTimerActive[index])
                            .onReceive(timer) { _ in
                                if isTimerActive[index] {
                                    elapsedTimes[index] += 1
                                } else {
                                    elapsedTimes[index] = 0
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
                DetailCard(title: "Ingredients",
                           details: details.extendedIngredients,
                           isExpanded: $ingredientsExpanded,
                           color: Color.background2)
                .frame(maxHeight: 60)
                .padding(.top, 90)
                .fullScreenCover(isPresented: $ingredientsExpanded) {
                    DetailCard(title: "Ingredients",
                               details: details.extendedIngredients,
                               isExpanded: $ingredientsExpanded,
                               color: Color.background2)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    CookingModeView(steps: Recipe.standard.recipeDetails!.analyzedInstructions[0].steps, details: Recipe.standard.recipeDetails!)
        .environment(RecipeManager())
}
