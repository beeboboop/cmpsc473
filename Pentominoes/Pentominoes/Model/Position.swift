//
//  Position.swift
//  Pentominoes
//
//  Created by Hannan, John Joseph on 9/5/23.
//

import Foundation
import UIKit



// identifies placement of a single pentomino on a board, including x/y coordinate   Uses unit coordinates on a 14 x 14 board

struct Position : Codable, Equatable {
    var x : Int = 0
    var y : Int = 0
    var orientation: Orientation = .up
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
    
    var rotationAngle : Int {
        switch orientation {
        case .up, .upMirrored:
            return 0
        case .right, .rightMirrored:
            return 90
        case .down, .downMirrored:
            return 180
        case .left, .leftMirrored:
            return 270
        }
    }

}

struct Offset {
    var x : Int = 0
    var y : Int = 0
}
