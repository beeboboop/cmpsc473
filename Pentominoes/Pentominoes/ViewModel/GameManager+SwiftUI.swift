//
//  GameManager+SwiftUI.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import Foundation
import SwiftUI

extension GameManager {
    var gridWidth : CGFloat {CGFloat(self.gameData.gridWidth)}
    var gridHeight : CGFloat {CGFloat(self.gameData.gridHeight)}
    var lineWidth : CGFloat {CGFloat(self.gameData.lineWidth)}
    var blockSize : CGFloat {CGFloat(self.gameData.blockSize)}
    
    func getWidth<GameObject : Outline>(outline: GameObject) -> CGFloat {
        return CGFloat(outline.size.width)
    }
    func getHeight<GameObject : Outline>(outline: GameObject) -> CGFloat {
        return CGFloat(outline.size.height)
    }
    
    func getXY(piece: Piece) -> (x: CGFloat, y: CGFloat) {
        if piece.isLandscape && getWidth(outline: piece.outline) != getHeight(outline: piece.outline){
            var offset : CGFloat = 0
            var xOffset : CGFloat = 0
            var yOffset: CGFloat = 0
            if getWidth(outline: piece.outline) > getHeight(outline: piece.outline) {
                offset = CGFloat(getWidth(outline: piece.outline)-getHeight(outline: piece.outline))/2.0
                xOffset = -offset
                yOffset = offset
            }
            else {
                offset = CGFloat(getHeight(outline: piece.outline)-getWidth(outline: piece.outline))/2.0
                xOffset = offset
                yOffset = -offset
            }
            return (CGFloat(piece.position.x) + xOffset, CGFloat(piece.position.y) + yOffset)
        }
        return (CGFloat(piece.position.x), CGFloat(piece.position.y))
    }
    
    func canPieceRotate(_ piece: Piece) -> Bool {
        if piece.isOnBoard {
            if piece.isLandscape {
                return piece.position.x + piece.outline.size.width <= 14 && piece.position.y + piece.outline.size.height <= 14
            }
            else {
                return piece.position.x + piece.outline.size.height <= 14 && piece.position.y + piece.outline.size.width <= 14
            }
        }
        return true
    }
    
    func getRotationAngleFor(_ piece: Piece) -> Angle {
        return Angle(degrees: CGFloat(piece.rotationAngle))
    }
    
    func getReflectionAxisFor(_ piece: Piece) -> (x: CGFloat, y: CGFloat, z: CGFloat) {
        switch piece.position.orientation {
        case .up, .down, .upMirrored, .downMirrored:
            return (CGFloat(0), CGFloat(1), CGFloat(0))
        default:
            return (CGFloat(1), CGFloat(0), CGFloat(0))
        }
    }
    
    func getReflectionAngleFor(_ piece: Piece) -> Angle {
        return Angle(degrees: piece.isMirrored ? 180 : 0)
    }
    
    func offset(for piece: Piece, from size: CGSize) -> Offset {
        let offset = Offset(x: Int(round(size.width/CGFloat(blockSize))),
               y: Int(round(size.height/CGFloat(blockSize))))
        if piece.isLandscape {
            if offset.x + piece.position.x < 0 || offset.x + piece.position.x + piece.outline.size.height > 14
                || offset.y + piece.position.y < 0 || offset.y + piece.position.y + piece.outline.size.width > 14 {
                return Offset()
            }
            return offset
        }
        if offset.x + piece.position.x < 0 || offset.x + piece.position.x + piece.outline.size.width > 14
            || offset.y + piece.position.y < 0 || offset.y + piece.position.y + piece.outline.size.height > 14 {
            return Offset()
        }
        return offset
    }
}
