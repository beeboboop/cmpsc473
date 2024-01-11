//
//  Persistence.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import Foundation

struct Persistence {
    let fileName: String
    let pokemon : [Pokemon]?
    
    init(fileName: String) {
        self.fileName = fileName
        let fileurl = URL.documentsDirectory.appendingPathComponent(fileName + ".json")
        if FileManager.default.fileExists(atPath: fileurl.path) {
            pokemon = data(from: fileurl)
        } else {
            let bundle = Bundle.main
            guard let url = bundle.url(forResource: fileName, withExtension: "json")
            else {pokemon = nil; return}
            pokemon = data(from: url)
        }
        
        func data(from url: URL) -> [Pokemon]? {
            var pokemon: [Pokemon]?
            do {
                let contents = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                pokemon = try decoder.decode([Pokemon].self, from: contents)
            } catch {
                print(error)
                pokemon = nil
            }
            return pokemon
        }
    }
    
    func save(_ pokemon: [Pokemon]) {
        let encoder = JSONEncoder()
        let url = URL.documentsDirectory.appendingPathComponent(fileName + ".json")
        do {
            let data = try encoder.encode(pokemon)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
}
