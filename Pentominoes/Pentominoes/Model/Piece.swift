//
//  Piece.swift
//  Pentominoes
//
//  Created by Hannan, John Joseph on 9/5/23.
//

import Foundation



//Each piece is fully determined by its outline and its position

struct Piece : Decodable, Identifiable {
    let outline : PentominoOutline
    var position : Position = Position()
    var id : String { outline.name }
    static let standard : Piece = Piece(outline: PentominoOutline.standard, position: Position())
    
    var isOnBoard : Bool {
        position.x >= 0 && position.x < 14 && position.x >= 0 && position.y < 14
    }
    
    var isMirrored : Bool {
        switch position.orientation {
        case .up, .down, .left, .right:
            return false
        default:
            return true
        }
    }
    
    var isLandscape : Bool {
        switch position.orientation {
        case .left, .right, .leftMirrored, .rightMirrored:
            return true
        default:
            return false
        }
    }
    
    
    var rotationAngle : Int = 0
    
    
    mutating func reflect()  {
        switch position.orientation {
        case .up:
            position.orientation = .upMirrored
        case .right:
            position.orientation = .rightMirrored
        case .down:
            position.orientation = .downMirrored
        case .left:
            position.orientation = .leftMirrored
        case .upMirrored:
            position.orientation = .up
        case .rightMirrored:
            position.orientation = .right
        case .downMirrored:
            position.orientation = .down
        case .leftMirrored:
            position.orientation = .left
        }
    }
    
    mutating func rotate() {
        switch position.orientation {
        case .up:
            position.orientation = .right
        case .right:
            position.orientation = .down
        case .down:
            position.orientation = .left
        case .left:
            position.orientation = .up
        case .upMirrored:
            position.orientation = .rightMirrored
        case .rightMirrored:
            position.orientation = .downMirrored
        case .downMirrored:
            position.orientation = .leftMirrored
        case .leftMirrored:
            position.orientation = .upMirrored
        }
    }
    
    mutating func moveBy(offset: Offset) {
        position.x += offset.x
        position.y += offset.y
    }

}
