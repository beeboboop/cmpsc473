//
//  PokemonRow.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import SwiftUI

struct PokemonRow: View {
    @Environment(PokedexManager.self) var manager
    @Environment(\.colorScheme) var colorScheme
    @Binding var pokemon : Pokemon
    
    var imageName : String {colorScheme == .light ? ImageNames.capturedLm : ImageNames.capturedDm}
    
    var body: some View {
        HStack {
            Text(pokemon.normId).font(.subheadline)
            Text(pokemon.name).font(.title2)
            Spacer()
            if pokemon.isCaptured {
                Image(imageName)
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            PokemonImage(pokemon: pokemon)
                .frame(width: 70, height: 70)
        }
        .padding()
    }
}

#Preview {
    PokemonRow(pokemon: .constant(Pokemon.standard))
        .environment(PokedexManager())
}
