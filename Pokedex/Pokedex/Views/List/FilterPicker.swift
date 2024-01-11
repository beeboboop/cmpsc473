//
//  FilterPicker.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/24/23.
//

import SwiftUI

struct FilterPicker: View {
    @Binding var filterType : PokemonType
    var body: some View {
        Picker("Type", selection: $filterType) {
            ForEach(PokemonType.allCases, id:\.self) {type in
                Text(type.rawValue)
            }
        }
    }
}
