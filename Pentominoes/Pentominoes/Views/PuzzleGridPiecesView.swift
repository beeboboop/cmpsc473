//
//  PuzzGridButtonsView.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/15/23.
//

import SwiftUI

struct PuzzleGridPiecesView: View {
    @EnvironmentObject var manager : GameManager
    let puzzleOutline : PuzzleOutline
    var body: some View {
        ZStack(alignment: .topLeading) {
            PuzzleOverGridView(puzzleOutline: puzzleOutline)
            ForEach($manager.pieces) {$piece in
                PieceView(piece: $piece)
            }
        }
    }
}
