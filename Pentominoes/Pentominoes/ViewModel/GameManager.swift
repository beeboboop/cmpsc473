//
//  GameManager.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/13/23.
//

import Foundation


class GameManager : ObservableObject {
    @Published var pieces : [Piece] = []
    let puzzleOutlines : [PuzzleOutline]
    let solutions : Solutions
    let gameData = GameData()
    let imageNames : [String]
    
    @Published var currentPuzzleOutline : PuzzleOutline
    var currentSolution : [String : Position] {solutions.getSolution(puzzleName: currentPuzzleOutline.name)}
    
    init() {
        puzzleOutlines = gameData.puzzleOutlines
        pieces = gameData.pieces
        solutions = gameData.solutions
        imageNames = gameData.imageNames
        currentPuzzleOutline = puzzleOutlines[0]
    }
}

extension GameManager {
    func changePuzzle(puzzleIndex: Int) {
        currentPuzzleOutline = puzzleOutlines[puzzleIndex]
        reset()
    }
    
    func solve() {
        for (pieceName, position) in currentSolution {
            let index = pieces.firstIndex(where: {$0.outline.name == pieceName}) ?? 0
            pieces[index].position.x = position.x
            pieces[index].position.y = position.y
            pieces[index].position.orientation = position.orientation
            pieces[index].rotationAngle = position.rotationAngle
        }
    }
    
    func reset() {
        pieces = gameData.pieces
    }
    
    func solutionPositionFor(_ piece: Piece) -> Position {
        currentSolution[piece.outline.name] ?? Position(x: 14, y:14)
    }
}
