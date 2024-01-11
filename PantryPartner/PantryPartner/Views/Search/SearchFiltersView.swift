//
//  SearchFiltersView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/19/23.
//

import SwiftUI
import SwiftData

struct SearchFiltersView: View {
    @Environment(RecipeManager.self) var manager
    @Environment(\.dismiss) var dismiss
    
    @Query (filter: #Predicate<PantryItem> {$0.isInPantry}) private var pantryItems : [PantryItem] = []
    
    var body: some View {
        @Bindable var manager = manager
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                Form {
                    Section("General") {
                        NavigationLink("Cuisine", destination: MultiPickerView(pickerType: Cuisine.self))
                        NavigationLink("Diet Type", destination: MultiPickerView(pickerType: Diet.self))
                        NavigationLink("Intolerances", destination: MultiPickerView(pickerType: Intolerance.self))
                        NavigationLink("Dish Type", destination: MultiPickerView(pickerType: DishType.self))
                        Picker("Sort Results By", selection: $manager.searchParameters.sortBy) {
                            ForEach(SortOption.allCases) { option in
                                Text(option.rawValue.localizedCapitalized)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    Section("Pantry") {
                        Toggle("Use ingredients from my pantry", isOn: $manager.searchParameters.includeIngredients)
                        Toggle("Ignore typical pantry items", isOn: $manager.searchParameters.ignorePantryStaples)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Search Filters")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        manager.clearQuery()
                        dismiss()
                    }) {
                        Text("Clear Filters")
                            .foregroundStyle(.red)
                            .opacity(
                                manager.areFiltersNotApplied ?
                                0.5 : 1
                            )
                    }
                    .disabled(manager.areFiltersNotApplied)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
        .onAppear {
            manager.searchParameters.ingredients = pantryItems
        }
    }
}
