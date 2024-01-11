//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import SwiftUI

struct PokemonImage: View {
    @Environment(PokedexManager.self) var manager
    let pokemon : Pokemon
    var body: some View {
        Image(pokemon.normId)
            .resizable()
            .padding(5)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(LinearGradient(pokemon: pokemon))
            }
    }
}

#Preview {
    PokemonImage(pokemon: Pokemon.standard)
        .environment(PokedexManager())
}
