//
//  GameView.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/12/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var manager : GameManager
    var body: some View {
        VStack() {
            HStack {
                VStack{
                    ForEach(0..<4) {i in
                        ChangePuzzleButton(image: manager.imageNames[i], action: {manager.changePuzzle(puzzleIndex: i)})
                    }
                    ActionButton(text: "Reset", color: .red, action: {manager.reset()})
                }
                PuzzleGridPiecesView(puzzleOutline: manager.currentPuzzleOutline)
                VStack {
                    ForEach(4..<8) {i in
                        ChangePuzzleButton(image: manager.imageNames[i], action: {manager.changePuzzle(puzzleIndex: i)})
                    }
                    ActionButton(text: "Solve", color: .green, action: {manager.solve()})
                }
            }
            Spacer()
        }
    }
}
