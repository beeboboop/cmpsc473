//
//  Solution.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/25/23.
//

import Foundation

struct Solutions : Codable {
    var sixByTen : [String:Position] = [:]
    var fiveByTwelve : [String:Position] = [:]
    var oneHole : [String:Position] = [:]
    var fourNotches : [String:Position] = [:]
    var fourHoles : [String:Position] = [:]
    var thirteenHoles : [String:Position] = [:]
    var flower : [String:Position] = [:]
    
    enum CodingKeys : String, CodingKey {
        case sixByTen = "6x10"
        case fiveByTwelve = "5x12"
        case oneHole = "OneHole"
        case fourNotches = "FourNotches"
        case fourHoles = "FourHoles"
        case thirteenHoles = "13Holes"
        case flower = "Flower"
    }
    
    func getSolution(puzzleName: String) -> [String:Position] {
        switch puzzleName {
        case "6x10":
            return sixByTen
        case "5x12":
            return fiveByTwelve
        case "OneHole":
            return oneHole
        case "FourNotches":
            return fourNotches
        case "FourHoles":
            return fourHoles
        case "13Holes":
            return thirteenHoles
        case "Flower":
            return flower
        default:
            return [:]
        }
    }
}
