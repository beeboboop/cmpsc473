//
//  Boolean.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/8/23.
//

import Foundation

extension Bool: Comparable {
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        return !lhs && rhs
    }
}
