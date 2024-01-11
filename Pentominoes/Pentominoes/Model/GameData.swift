//
//  GameData.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import Foundation

struct GameData {
    var pieces : [Piece] = []
    var puzzleOutlines : [PuzzleOutline] = []
    var solutions : Solutions = Solutions()
    let imageNames : [String] = ["Board0button", "Board1button", "Board2button", "Board3button", "Board4button", "Board5button", "Board6button", "Board7button"]
    let blockSize : Int = 40
    let lineWidth : Int = 2
    let gridWidth : Int = 14
    let gridHeight : Int = 14
    
    init() {
        var pentominoOutlines : [PentominoOutline] = []
        let bundle = Bundle.main
        guard let pentominoUrl = bundle.url(forResource: "PentominoOutlines", withExtension: "json")
        else {return}
        
        guard let puzzleUrl = bundle.url(forResource: "PuzzleOutlines", withExtension: "json")
        else {return}
        
        guard let solutionUrl = bundle.url(forResource: "Solutions", withExtension: "json")
        else {return}
        
        
        let decoder = JSONDecoder()
        do {
            let pentominoContents = try Data(contentsOf: pentominoUrl)
            pentominoOutlines = try decoder.decode([PentominoOutline].self, from: pentominoContents)
        }
        catch {
            print(error)
        }
        
        do {
            let puzzleContents = try Data(contentsOf: puzzleUrl)
            puzzleOutlines = try decoder.decode([PuzzleOutline].self, from: puzzleContents)
        }
        catch {
            print(error)
        }
        
        do {
            let solutionContents = try Data(contentsOf: solutionUrl)
            solutions = try decoder.decode(Solutions.self, from: solutionContents)
        }
        catch {
            print(error)
        }
        
        puzzleOutlines.insert(PuzzleOutline(name: "Empty", size: Size(width: 0, height: 0), outlines: []), at: 0)
        for i in 0..<3 {
            for j in 0..<4 {
                pieces.append(Piece(outline: pentominoOutlines[i*4+j], position: Position(x: j*5 - 2, y: i*6 + 15)))
            }
        }
    }
}
