//
//  Cuisine.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import Foundation

enum Cuisine : String, FilterEnumProtocol {
    case african, asian, american, british, cajun, caribbean, chinese
    case easternEuropean = "eastern european", european, french, german, greek, indian
    case irish, italian, japanese, jewish, korean, latinAmerican = "latin american"
    case mediterranean, mexican, middleEastern = "middle eastern", nordic
    case southern, spanish, thai, vietnamese
    
    var sectionTitle : String {
        switch self {
        case .african: return "African Delicacies"
        case .asian: return "Amazingly Asian"
        case .american: return "Classic American"
        case .british: return "British Flavors"
        case .cajun: return "Cajun Cuisine"
        case .caribbean: return "Caribbean Dishes"
        case .chinese: return "Chinese Delights"
        case .easternEuropean: return "Eastern European Eats"
        case .european: return "European Treats"
        case .french: return "French Cuisine"
        case .german: return "German Gastronomy"
        case .greek: return "Greek Specialties"
        case .indian: return "Exquisite Indian"
        case .irish: return "Irish Fare"
        case .italian: return "Italian Classics"
        case .japanese: return "Japanese Cuisine"
        case .jewish: return "Traditional Jewish"
        case .korean: return "Korean Delicacies"
        case .latinAmerican: return "Latin American Flavors"
        case .mediterranean: return "Mouthwatering Mediterranean"
        case .mexican: return "Authentic Mexican"
        case .middleEastern: return "Middle Eastern Delights"
        case .nordic: return "Nordic Specialties"
        case .southern: return "Southern Comfort"
        case .spanish: return "Spanish Specialties"
        case .thai: return "Thai Tastes"
        case .vietnamese: return "Vibrant Vietnamese"
        }
    }
    
    var id : Self {
        return self
    }
}
