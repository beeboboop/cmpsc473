//
//  Nutrient.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import Foundation

struct Nutrient : Decodable, Identifiable {
    let name : String
    let amount : Double
    let unit : String
    let percentOfDailyNeeds : Double
    
    var id : String {
        return self.name
    }
    
    var amountString : String {
        return "\(self.amount) \(self.unit)"
    }
    
    var percentString : String {
        return String(format: "%.2f", self.percentOfDailyNeeds) + "%"
    }
}
