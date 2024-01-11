//
//  HomeView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/25/23.
//

import SwiftUI

struct HomeView: View {
    @Environment(PokedexManager.self) var manager
    
    var anyCaptured : Bool {
        !manager.capturedPokemon.isEmpty
    }
    var body: some View {
        NavigationStack {
            List {
                if anyCaptured {
                    Section("Captured") {
                        HomeRowView(type: nil)
                    }
                }
                ForEach(PokemonType.allCases, id:\.self) {type in
                    if type != .none {
                        Section(type.rawValue) {
                            HomeRowView(type: type)
                        }
                    }
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
        .environment(PokedexManager())
}
