//
//  WordListView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct WordListView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        ScrollViewReader {proxy in
            ScrollView(.horizontal) {
                HStack {
                    if (gameManager.acceptedWords.isEmpty) {
                        Text(" ")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding([.top, .bottom], 10)
                    }
                    ForEach(gameManager.acceptedWords, id: \.self) { word in
                        Text(word)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding([.top, .bottom], 10)
                            .id(gameManager.acceptedWords.firstIndex(of: word))
                    }
                }
            }
            .onChange(of: gameManager.acceptedWords, perform: {value in
                proxy.scrollTo(gameManager.acceptedWords.endIndex)
            })
        }
        .background(.blue)
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView()
    }
}
