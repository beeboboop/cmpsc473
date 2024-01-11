//
//  Grid.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct Grid: Shape {
    let n : CGFloat
    let m : CGFloat
    func path(in rect: CGRect) -> Path {
        let horizOffset = rect.width/n
        let vertOffset = rect.height/m
        
        var path = Path()
        for i in stride(from: CGFloat(0), through: rect.width, by: horizOffset) {
            path.move(to: CGPoint(x: rect.minX+i, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX+i, y: rect.maxY))
        }
        
        for i in stride(from: CGFloat(0), through: rect.height, by: vertOffset) {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY+i))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY+i))
        }
        
        return path
    }
}
