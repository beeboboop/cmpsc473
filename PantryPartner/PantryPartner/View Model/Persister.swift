//
//  Persister.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import Foundation

struct Persister {
    let fileName: String
    let user : User
    
    init(fileName: String) {
        self.fileName = fileName
        let fileurl = URL.documentsDirectory.appendingPathComponent(fileName + ".json")
        if FileManager.default.fileExists(atPath: fileurl.path) {
            user = data(from: fileurl)
        } else {
            let bundle = Bundle.main
            guard let url = bundle.url(forResource: fileName, withExtension: "json")
            else {user = User(); return}
            user = data(from: url)
        }
        
        func data(from url: URL) -> User {
            var user: User
            do {
                let contents = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                user = try decoder.decode(User.self, from: contents)
            } catch {
                print(error)
                user = User()
            }
            return user
        }
    }
    
    func save(_ user: User) {
        let encoder = JSONEncoder()
        let url = URL.documentsDirectory.appendingPathComponent(fileName + ".json")
        do {
            let data = try encoder.encode(user)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
}
