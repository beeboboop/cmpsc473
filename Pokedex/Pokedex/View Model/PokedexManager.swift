//
//  PokedexManager.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import Foundation
import UIKit

@Observable
class PokedexManager {
    var pokemon : [Pokemon]
    let persister : Persistence
    
    init() {
        persister = Persistence(fileName: "pokedex")
        pokemon = persister.pokemon ?? []
    }
}

//Computed variables
extension PokedexManager {
    var capturedPokemon : [Pokemon] {pokemon.filter({$0.isCaptured})}
}

//Functions
extension PokedexManager {
    func getIndexOf(_ mon: Pokemon) -> Int? {
        pokemon.firstIndex(of: mon)
    }
}
