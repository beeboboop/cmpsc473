//
//  PuzzleOverGrid.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct PuzzleOverGridView: View {
    @EnvironmentObject var manager : GameManager
    let puzzleOutline : PuzzleOutline
    var body: some View {
        ZStack {
            Grid(n: manager.gridWidth, m: manager.gridHeight)
                .stroke(style: StrokeStyle(lineWidth: manager.lineWidth))
            Puzzle(puzzleOutline: puzzleOutline)
                .fill(style: FillStyle(eoFill: true))
                .opacity(0.50)
                .frame(width: manager.blockSize*manager.getWidth(outline: puzzleOutline),
                       height: manager.blockSize*manager.getHeight(outline: puzzleOutline))
        }
        .frame(width:manager.gridWidth*manager.blockSize, height:manager.gridHeight*manager.blockSize)
    }
}

