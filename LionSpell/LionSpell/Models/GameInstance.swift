//
//  GameInstance.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/31/23.
//

import Foundation

struct GameInstance {
    let allWords: [String]
    var matchingWords : [String] = []
    var wordCountPerChar : [Int: [Character: Int]] = [:]
    var letters: [Character]
    let mustHaveLetter : Character
    var maxWordLength : Int = 0
    var minWordLength : Int = 0
    
    init(preferences : Preferences) {
        func hasAllUniqueChars(str: String) -> Bool {
            let charArray = Array(str.utf8.sorted())
            for i in 0..<charArray.count-1 {
                if charArray[i] == charArray[i+1] {
                    return false
                }
            }
            return true
        }
        func getWordCountsForLetter (wordLength: Int) -> [Character: Int] {
            var returnDict : [Character: Int] = [:]
            for char in letters {
                returnDict[char] = matchingWords.filter() {$0.count == wordLength && $0.first! == char}.count
            }
            return returnDict
        }
        
        switch preferences.language {
        case .english:
            allWords = Words.englishWords
        case .french:
            allWords = Words.frenchWords
        case .italian:
            allWords = Words.italianWords
        case .german:
            allWords = Words.germanWords
        }
        
        let _nLetterWords = allWords.filter() {
            $0.count == preferences.numberOfLetters.value && hasAllUniqueChars(str: $0)
        }
        letters = Array(_nLetterWords.randomElement()!).shuffled()
        mustHaveLetter = letters.randomElement()!
        letters.swapAt(0, letters.firstIndex(of: mustHaveLetter)!)
        
        let _matchingWords = allWords.filter() {
            $0.allSatisfy({char in letters.contains(char)}) && $0.contains(mustHaveLetter)
        }
        matchingWords = _matchingWords
        
        maxWordLength = matchingWords.max(by: {$1.count > $0.count})!.count
        minWordLength = matchingWords.min(by: {$1.count > $0.count})!.count
        
        var _tempDict: [Int: [Character: Int]] = [:]
        for wordLength in minWordLength...maxWordLength {
            _tempDict[wordLength] = getWordCountsForLetter(wordLength: wordLength)
        }
        wordCountPerChar = _tempDict
        
    }
}

extension GameInstance {
    mutating func shuffleLetters() {
        letters[1...].shuffle()
    }
    
    var totalPossibleWords : Int {matchingWords.count}
    var totalPossiblePoints : Int {
        var _sum = 0
        for word in matchingWords {
            _sum += word.count == 4 ? 1 : letters.allSatisfy({word.contains($0)}) ? word.count+10 : word.count
        }
        return _sum
    }
    var totalPangrams : Int {
        var _count = 0
        for word in matchingWords {
            _count += letters.allSatisfy(({word.contains($0)})) ? 1 : 0
        }
        return _count
    }
}
