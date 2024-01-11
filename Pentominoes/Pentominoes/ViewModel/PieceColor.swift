//
//  PieceColor.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import Foundation
import SwiftUI

extension Color {
    static func getPieceColor(piece: Piece) -> Color {
        let colors : [String:Color] = ["X":.red, "P":.blue, "F":.yellow, "W":.cyan, "Z":.green, "U":.orange, "V":.purple, "T":.pink, "L":.indigo, "Y":.mint, "N":.teal, "I":.white]
        return colors[piece.outline.name] ?? .red
    }
}
