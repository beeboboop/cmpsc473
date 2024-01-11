//
//  EvolutionsView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/25/23.
//

import SwiftUI

struct EvolutionsView: View {
    @Environment(PokedexManager.self) var manager
    let evolutions : [Int]
    let title : String
    var body: some View {
        @Bindable var manager = manager
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
            ScrollView(.horizontal){
                HStack {
                    ForEach(evolutions, id:\.self) { index in
                        NavigationLink(destination: PokemonDetailView(pokemon: $manager.pokemon[index-1])) {
                            PokemonCard(pokemon: $manager.pokemon[index-1])
                                .scaleEffect(CGSize(width: 0.3, height: 0.3))
                                .frame(width: 150, height: 150)
                        }
                    }
                }
            }
        }
        .padding([.leading, .trailing])
    }
    
}
