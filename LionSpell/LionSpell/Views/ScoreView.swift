//
//  ScoreView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        Text("\(gameManager.score)")
            .font(.largeTitle)
            .bold()
            .padding()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
