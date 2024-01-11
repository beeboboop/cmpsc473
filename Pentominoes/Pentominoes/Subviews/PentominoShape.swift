//
//  Pentomino.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct Pentomino: Shape {
    let outline : PentominoOutline
    func path(in rect: CGRect) -> Path {
        let horizOffset = rect.width/CGFloat(outline.size.width)
        let vertOffset = rect.height/CGFloat(outline.size.height)
        var x = rect.minX + CGFloat(outline.outline[0].x)*horizOffset
        var y = rect.minY + CGFloat(outline.outline[0].y)*vertOffset
        
        var path = Path()
        path.move(to: CGPoint(x: x, y: y))
        for point in outline.outline {
            x = rect.minX + CGFloat(point.x)*horizOffset
            y = rect.minY + CGFloat(point.y)*vertOffset
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.closeSubpath()
        return path
    }
}
