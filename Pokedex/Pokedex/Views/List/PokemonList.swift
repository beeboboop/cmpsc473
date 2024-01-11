//
//  PokemonList.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import SwiftUI

struct PokemonList: View {
    @Environment(PokedexManager.self) var manager
    @AppStorage(Storage.filterType) var filterType : PokemonType = .none
    var body: some View {
        @Bindable var manager = manager
        NavigationStack {
            List {
                ForEach($manager.pokemon) {$pokemon in
                    if pokemon.types.contains(filterType) || filterType == .none {
                        HStack {
                            NavigationLink(destination: PokemonDetailView(pokemon: $pokemon)) {
                                PokemonRow(pokemon: $pokemon)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    FilterPicker(filterType: $filterType)
                }
            }
            .navigationTitle("Pokedex")
        }
    }
}

#Preview {
    PokemonList()
        .environment(PokedexManager())
}
