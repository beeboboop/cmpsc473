//
//  TypesView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/18/23.
//

import SwiftUI

struct TypesView: View {
    let title : String
    let types : [PokemonType]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
            TypeIconList(types: types)
        }
        .padding(.leading)
    }
}

struct TypeIconList: View {
    let types : [PokemonType]
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(types) { type in
                    TypeIcon(type: type)
                }
            }
        }
    }
}

struct TypeIcon: View {
    let type : PokemonType
    var body: some View {
        ZStack {
            Text(type.rawValue)
                .bold()
                .foregroundStyle(.white)
                .padding(10)
                .background() {
                    Capsule()
                        .fill(Color(pokemonType: type))
                }
        }
    }
}

#Preview {
    TypeIconList(types: [.bug, .dragon, .fire])
}
