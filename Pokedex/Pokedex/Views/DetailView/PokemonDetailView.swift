//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(PokedexManager.self) var manager
    @Environment(\.colorScheme) var colorScheme
    @Binding var pokemon : Pokemon
    
    //Extremely hacky way of updating image to fix strange bug with uncapturing
    //a captured pokemon after navigating from card in HomeView "Captured" row
    var imageName : String {
        switch colorScheme {
        case .dark:
            //Old implemenation
            //pokemon.isCaptured ? ImageNames.capturedDm : ImageNames.notCapturedDM
            manager.pokemon[manager.getIndexOf(pokemon)!].isCaptured ? ImageNames.capturedDm : ImageNames.notCapturedDm
        default:
            manager.pokemon[manager.getIndexOf(pokemon)!].isCaptured ? ImageNames.capturedLm : ImageNames.notCapturedLm
        }
    }
    
    var body: some View {
        @Bindable var manager = manager
        ScrollView(.vertical) {
            VStack {
                PokemonCard(pokemon: $pokemon)
                    .scaleEffect(CGSize(width: 0.7, height: 0.7))
                    .frame(width: 300, height: 350)
                HStack {
                    Spacer()
                    StatText(title: "Height", stat: pokemon.height, units: "m")
                    Spacer()
                    StatText(title: "Weight", stat: pokemon.weight, units: "kg")
                    Spacer()
                }
                TypesView(title: "Weaknesses", types: pokemon.weaknesses)
                HStack {
                    if let evo = pokemon.prevEvolution {
                        EvolutionsView(evolutions: evo, title: "Evolves from")
                    }
                    if let evo = pokemon.nextEvolution {
                        EvolutionsView(evolutions: evo, title: "Evolves into")
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {pokemon.isCaptured.toggle()}) {
                    Image(imageName)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
        .navigationTitle(pokemon.name)
    }
}

#Preview {
    PokemonDetailView(pokemon: .constant(Pokemon.standard))
        .environment(PokedexManager())
}
