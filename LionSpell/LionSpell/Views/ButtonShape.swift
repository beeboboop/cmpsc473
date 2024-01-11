//
//  ButtonShape.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 9/12/23.
//

import SwiftUI

struct ButtonShape : Shape {
    let numLetters : Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        switch numLetters {
        case 5 :
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.closeSubpath()
        case 6 :
            path.move(to: CGPoint(x: (rect.minX + rect.midX) / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: (rect.midX + rect.maxX) / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: (rect.midY + rect.minY) / 1.25))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: (rect.midY + rect.minY) / 1.25))
            path.closeSubpath()
        case 7 :
            path.move(to: CGPoint(x: (rect.minX + rect.midX) / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: (rect.midX + rect.maxX) / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: (rect.midX + rect.maxX) / 2, y: rect.minY))
            path.addLine(to: CGPoint(x: (rect.minX + rect.midX) / 2, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.closeSubpath()
        default:
            return path
        }
        return path
    }
}
