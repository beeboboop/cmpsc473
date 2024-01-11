//
//  Equipment.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation

struct Equipment : Decodable {
    let id : Int
    let name : String
    let image : String?
    let temperature : Temperature?
}
