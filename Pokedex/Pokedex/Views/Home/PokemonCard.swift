//
//  PokemonCard.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/25/23.
//

import SwiftUI

struct PokemonCard: View {
    @Environment(PokedexManager.self) var manager
    @Environment(\.colorScheme) var colorScheme
    @Binding var pokemon : Pokemon
    
    var imageName : String {colorScheme == .light ? ImageNames.capturedLm : ImageNames.capturedDm}
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50).fill(LinearGradient(pokemon: pokemon))
            RoundedRectangle(cornerRadius: 50).stroke(.black, lineWidth: 8)
            ZStack {
                ZStack {
                    Image(pokemon.normId)
                        .resizable()
                        .offset(x: 0, y: -30)
                        .opacity(0.12)
                        .shadow(radius: 10)
                        .frame(width:500, height: 500)
                    Image(pokemon.normId)
                        .resizable()
                        .padding(5)
                        .frame(width: 300, height: 300)
                }
                .offset(x: 0, y: 50)
                
                HStack {
                    Text(pokemon.normId)
                        .font(.system(size: 30, design: .default))
                        .foregroundStyle(.white)
                    Text(pokemon.name)
                        .font(.system(size: 70, design: .default))
                        .bold()
                        .foregroundStyle(.white)
                }
                .offset(y: -130)
                
                //More hackiness for same bug
                if manager.pokemon[manager.getIndexOf(pokemon)!].isCaptured {
                    Image(imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .offset(x: -180, y: 240)
                }
                
                HStack {
                    ForEach(pokemon.types, id:\.self) {type in
                        TypeIcon(type: type)
                            .shadow(radius: 10)
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                            .padding()
                    }
                }
                .offset(y: 240)
            }
            .offset(y: -50)
        }
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .animation(.linear(duration: 0.2), value: manager.pokemon[manager.getIndexOf(pokemon)!].isCaptured)
    }
}

#Preview {
    PokemonCard(pokemon: .constant(Pokemon.standard))
}
