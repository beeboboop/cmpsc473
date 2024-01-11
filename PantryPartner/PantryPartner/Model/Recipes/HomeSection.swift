//
//  HomeSection.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/16/23.
//

import Foundation
//TODO: Refactor using polymorphism (or associate value?)
struct HomeSection: Identifiable, Equatable {
    var recipes : [Recipe]?
    let cuisine : Cuisine?
    let diet : Diet?
    var id : UUID = UUID()
    
    static func == (lhs: HomeSection, rhs: HomeSection) -> Bool {
        return lhs.id == rhs.id
    }
}
