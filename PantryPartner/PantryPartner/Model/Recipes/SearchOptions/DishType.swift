//
//  MealType.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/18/23.
//

import Foundation

enum DishType : String, FilterEnumProtocol {
    case mainCourse = "main course", sideDish = "side dish", dessert
    case appetizer, salad, bread, breakfast, soup, beverage, sauce
    case marinade, fingerfood, snack, drink
    
    var id : Self {
        return self
    }
}
