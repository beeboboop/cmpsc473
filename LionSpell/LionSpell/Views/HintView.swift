//
//  HintView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 9/10/23.
//

import SwiftUI

struct HintView: View {
    @EnvironmentObject var gameManager : GameManager
    @Environment(\.dismiss) var dismiss
    @Binding var preferences : Preferences
    var body: some View {
        VStack(alignment: .trailing) {
            Button("Dismiss") {
                dismiss()
            }.padding()
            Form {
                Section("Summary") {
                    LabeledContent("Total Possible Words", value: "\(gameManager.game.totalPossibleWords)")
                    LabeledContent("Total Possible Points", value: "\(gameManager.game.totalPossiblePoints)")
                    LabeledContent("Number of Pangrams", value: "\(gameManager.game.totalPangrams)")
                }
                ForEach(gameManager.game.minWordLength...gameManager.game.maxWordLength, id: \.self) {wordLength in
                    Section("Words of Length: \(wordLength)") {
                        ForEach(gameManager.game.letters, id: \.self) {char in
                            let wordCount = gameManager.game.wordCountPerChar[wordLength]![char]
                            if wordCount != 0 {
                                LabeledContent("\(String(char).capitalized)", value: "\(gameManager.game.wordCountPerChar[wordLength]![char] ?? 0)")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct HintView_Previews: PreviewProvider {
    static var previews: some View {
        HintView(preferences: .constant(Preferences()))
    }
}
