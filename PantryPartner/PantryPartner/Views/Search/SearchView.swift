//
//  SearchView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import SwiftUI

struct SearchView: View {
    @Environment(RecipeManager.self) var manager
    @State private var searchString = ""
    @State private var isPresentingFilters = false
    @FocusState private var isTyping : Bool
    
    var body: some View {
        @Bindable var manager = manager
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    SearchBar(searchString: $searchString,
                              isPresentingFilters: $isPresentingFilters,
                              isTyping: $isTyping)
                        .padding()
                    if !manager.searchResults.isEmpty {
                        SearchResultsView(number: manager.numResults,
                                          queryParameters: $manager.searchParameters)
                    } else {
                        Spacer()
                    }
                }
            }
            .navigationTitle("Search")
            .onTapGesture {
                isTyping = false
            }
            .animation(.easeInOut, value: manager.searchResults)
            .sheet(isPresented: $isPresentingFilters, content: {
                SearchFiltersView()
            })
        }
        .onAppear {
            UIScrollView.appearance().bounces = true
        }
    }
}

#Preview {
    SearchView()
        .environment(RecipeManager())
}
