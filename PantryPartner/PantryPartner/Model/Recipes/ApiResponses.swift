//
//  ApiResponse.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/6/23.
//

import Foundation

protocol ApiResponseBulk : Decodable {
    var results : [Recipe] { get set }
}

protocol ApiResponse : Decodable {
    var result : Recipe { get set }
}

struct ResponseRandom : ApiResponseBulk {
    var results : [Recipe]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Recipe].self, forKey: .recipes)
    }
    
    enum CodingKeys : CodingKey {
        case recipes
    }
}

struct ResponseInformation : ApiResponse {
    var result : Recipe
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.result = try container.decode(Recipe.self)
    }
    
    enum CodingKeys : CodingKey {
        case recipe
    }
}

struct ResponseBInformation : ApiResponseBulk {
    var results : [Recipe]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.results = try container.decode([Recipe].self)
    }
    
    enum CodingKeys : CodingKey {
        case recipes
    }
}

struct ResponseSearch : ApiResponseBulk {
    var results : [Recipe]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decode([Recipe].self, forKey: .results)
    }
    
    enum CodingKeys : CodingKey {
        case results
    }
}

struct ResponseAutoIngredient : ApiResponseBulk {
    var results : [Recipe]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.results = try container.decode([Recipe].self)
    }
    
    enum CodingKeys : CodingKey {
        case results
    }
}

