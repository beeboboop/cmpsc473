//
//  Puzzle.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct Puzzle: Shape {
    let puzzleOutline : PuzzleOutline
    func path(in rect: CGRect) -> Path {
        let horizOffset = rect.width/CGFloat(puzzleOutline.size.width)
        let vertOffset = rect.height/CGFloat(puzzleOutline.size.height)
        
        var path = Path()
        for outline in puzzleOutline.outlines {
            var x = rect.minX + CGFloat(outline[0].x)*horizOffset
            var y = rect.minY + CGFloat(outline[0].y)*vertOffset
            path.move(to: CGPoint(x: x, y: y))
            for point in outline {
                x = rect.minX + CGFloat(point.x)*horizOffset
                y = rect.minY + CGFloat(point.y)*vertOffset
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}
