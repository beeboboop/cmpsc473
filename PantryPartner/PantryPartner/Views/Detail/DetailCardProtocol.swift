//
//  DetailCardProtocol.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import Foundation

protocol DetailCardProtocol : Identifiable {
    var displayName : String { get }
    var bulletStyle : String { get }
}
