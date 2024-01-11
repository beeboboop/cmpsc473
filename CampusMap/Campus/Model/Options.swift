//
//  FilterOptions.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/5/23.
//

import Foundation

enum FilterOptions {
    case all, favorited, selected, nearby
}

enum MapOptions : String, CaseIterable {
    case standard = "Standard"
    case hybrid = "Hybrid"
    case imagery = "Imagery"
}
