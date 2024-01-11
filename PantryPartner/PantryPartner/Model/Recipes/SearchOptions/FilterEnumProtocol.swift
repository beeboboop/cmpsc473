//
//  FilterEnumProtocol.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/19/23.
//

import Foundation

protocol FilterEnumProtocol : CaseIterable, Identifiable, Hashable, Codable where AllCases == Array<Self> {
    var rawValue : String { get }
}
