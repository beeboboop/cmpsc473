//
//  Pokemon.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import Foundation

struct Pokemon: Codable, Identifiable, Hashable {
    let id : Int
    let name : String
    let types : [PokemonType]
    let height : Double
    let weight : Double
    let weaknesses : [PokemonType]
    let nextEvolution : [Int]?
    let prevEvolution : [Int]?
    var isCaptured : Bool
    
    enum CodingKeys : String, CodingKey {
        case id, name, types, height, weight, weaknesses, isCaptured
        case nextEvolution = "next_evolution"
        case prevEvolution = "prev_evolution"
    }
}

extension Pokemon {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.types = try container.decode([PokemonType].self, forKey: .types)
        self.height = try container.decode(Double.self, forKey: .height)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.weaknesses = try container.decode([PokemonType].self, forKey: .weaknesses)
        self.nextEvolution = try container.decodeIfPresent([Int].self, forKey: .nextEvolution)
        self.prevEvolution = try container.decodeIfPresent([Int].self, forKey: .prevEvolution)
        self.isCaptured = try container.decodeIfPresent(Bool.self, forKey: .isCaptured) ?? false
    }
}

extension Pokemon {
    var normId : String {String(format: "%03d", id)}
    
    static let standard : Pokemon = Pokemon(id: 147, name: "Paras", types: [.bug, .grass], height: 0.30, weight: 5.4, weaknesses: [.fire, .bug, .ice, .poison, .flying, .rock], nextEvolution: [47, 48], prevEvolution: [45], isCaptured: true)
}

extension Pokemon : Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
