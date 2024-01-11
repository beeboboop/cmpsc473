//
//  GameManager.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 9/4/23.
//

import Foundation

class GameManager: ObservableObject {
    var preferences : Preferences = Preferences()
    @Published var game : GameInstance
    @Published var currentWord : [Character] = []
    @Published var acceptedWords : [String] = []
    @Published var score : Int = 0
    
    init(preferences : Preferences) {
        self.preferences = preferences
        game = GameInstance(preferences: preferences)
    }
    
}

extension GameManager {
    var isCurrentWordValid : Bool {game.matchingWords.contains(String(currentWord))}
    
    func shuffle() {
        game.shuffleLetters()
    }
    
    func restart() {
        game = GameInstance(preferences: preferences)
        currentWord = []
        acceptedWords = []
        score = 0
    }
    
    func enterLetter(char: Character) {
        currentWord.append(char)
    }
    
    func delete() {
        currentWord.removeLast()
    }
    
    func submitWord() {
        if currentWord.count == 4 {
            score += 1
        }
        else {
            score += currentWord.count
            if game.letters.allSatisfy({currentWord.contains($0)}) {
                score += 10
            }
        }
        acceptedWords.append(String(currentWord))
        currentWord = []
    }
}
