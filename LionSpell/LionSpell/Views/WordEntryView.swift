//
//  WordEntryView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct WordEntryView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        HStack {
            if (gameManager.currentWord.isEmpty) {
                Text(" ")
                    .font(.title)
                    .bold()
            }
            ForEach(gameManager.currentWord, id: \.self) { char in
                Text(String(char))
                    .font(.title)
                    .bold()
            }
        }
        
    }
}

struct WordEntryView_Previews: PreviewProvider {
    static var previews: some View {
        WordEntryView()
    }
}
