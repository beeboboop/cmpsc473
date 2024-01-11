//
//  HomeRowView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/25/23.
//

import SwiftUI

struct HomeRowView: View {
    @Environment(PokedexManager.self) var manager
    let type : PokemonType? //set to nil to get captured pokemon
    
    var filteredPokemon : Set<Pokemon> {type != nil ? Set(manager.pokemon.filter({$0.types.contains(type!)})) : Set(manager.pokemon.filter({$0.isCaptured}))}
    
    var body: some View {
        @Bindable var manager = manager
        if !filteredPokemon.isEmpty {
            ScrollView(.horizontal) {
                HStack {
                    ForEach($manager.pokemon) {$pokemon in
                        if filteredPokemon.contains(pokemon) {
                            NavigationLink(destination: PokemonDetailView(pokemon: $pokemon)) {
                                PokemonCard(pokemon: $pokemon)
                                    .scaleEffect(CGSize(width: 0.3, height: 0.3))
                                    .frame(width: 150, height: 150)
                            }
                        }
                    }
                }
            }
        }
    }
}
