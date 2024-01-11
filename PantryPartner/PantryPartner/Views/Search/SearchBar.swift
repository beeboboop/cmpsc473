//
//  SearchBar.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/18/23.
//

import SwiftUI

struct SearchBar: View {
    @Environment(RecipeManager.self) var manager
    @Binding var searchString : String
    @Binding var isPresentingFilters : Bool
    var isTyping : FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            SearchTextField(searchString: $searchString,
                            isTyping: isTyping)
                .onSubmit {
                    manager.clearResults()
                    manager.searchParameters.query = searchString
                    manager.searchParameters.offset = 0
                    Task {
                        await manager.complexSearch(number: manager.numResults,
                                                    queryParameters: manager.searchParameters)
                    }
                }
            Button(action: {isPresentingFilters.toggle()}) {
                ZStack {
                    Image(systemName: "slider.horizontal.3")
                        .foregroundStyle(.gray)
                    if !manager.areFiltersNotApplied {
                        Image(systemName: "exclamationmark")
                            .foregroundStyle(.white)
                            .scaleEffect(CGSize(width: 0.75, height: 0.5))
                            .background(
                                Circle()
                                    .fill(.red)
                                    .scaleEffect(2.25)
                            )
                            .offset(x: 6, y: -6)
                    }
                }
            }
        }
        
    }
}

