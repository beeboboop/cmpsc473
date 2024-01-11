//
//  Preferences.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 9/5/23.
//

import Foundation

struct Preferences {
    var language : Language = .english
    var numberOfLetters : NumberOfLetters = .five
}

enum Language: String, CaseIterable, Identifiable {
    case english, french, italian, german
    var id : RawValue {rawValue}
}

enum NumberOfLetters: String, CaseIterable, Identifiable {
    case five, six, seven
    var id : RawValue {rawValue}
    
    var value: Int {
        switch self {
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        }
    }
}
