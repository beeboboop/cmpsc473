//
//  SimpleRecipe.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/8/23.
//

import Foundation
import SwiftData

/*@Model
class Recipe : Decodable, Identifiable, Displayable {
    @Attribute(.unique) let id : Int
    let recipeName : String
    let image : String
    var imageData : Data?
    var isFavorited : Bool = false
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.recipeName = try container.decode(String.self, forKey: .title)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    enum CodingKeys: CodingKey {
        case id, title, image
    }
}*/
