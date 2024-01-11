//
//  Ingredient.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/3/23.
//

import Foundation

struct Ingredient : Decodable, DetailCardProtocol {
    let spoonacularId : Int
    let name : String
    let originalName : String?
    let image : String?
    var amount : Double?
    let unit : String?
    var id : UUID = UUID()
    
    enum CodingKeys: String, CodingKey {
        case spoonacularId = "id"
        case name
        case originalName
        case image
        case amount
        case unit
    }
    
    var displayName : String {
        if let originalName {
            return "\(amountString ?? "") \(unit ?? "") \(originalName)"
        } else {
            return "\(amountString ?? "") \(unit ?? "") \(name)"
        }
    }
    
    let bulletStyle: String = "•\t"
    
    var amountString : String? {
        if let amount {
            return String(format: "%.2f", amount)
        } else {
            return nil
        }
    }
}

extension Ingredient {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.spoonacularId = try container.decode(Int.self, forKey: .spoonacularId)
        self.name = try container.decode(String.self, forKey: .name)
        self.originalName = try container.decodeIfPresent(String.self, forKey: .originalName)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.amount = try container.decodeIfPresent(Double.self, forKey: .amount)
        self.unit = try container.decodeIfPresent(String.self, forKey: .unit)
    }
}
