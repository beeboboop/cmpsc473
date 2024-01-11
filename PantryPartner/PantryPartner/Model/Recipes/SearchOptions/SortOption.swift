//
//  SortOption.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation

enum SortOption : String, FilterEnumProtocol {
    case popularity, healthiness, price, time, calories, random
    
    var id : Self {
        return self
    }
}
