//
//  RootView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

enum Showing : String, Identifiable, CaseIterable {
    case preferences, hints
    var id: RawValue {rawValue}
}

struct RootView: View {
    @State private var showing : Showing?
    @State private var preferencesChanged : Bool = false
    
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            ScoreView()
            Spacer()
            WordListView()
            WordEntryView()
            Spacer()
            Group {
                LetterButtonsView()
                Spacer()
                EditingButtonsView()
            }
            MenuButtonsView(showing: $showing)
        }
        .sheet(item: $showing, onDismiss: {
            if preferencesChanged {
                gameManager.restart()
                preferencesChanged = false
            }
        }) { item in
            switch item {
            case .preferences :
                PreferencesView(preferences: $gameManager.preferences, preferencesChanged: $preferencesChanged)
            case .hints :
                HintView(preferences: $gameManager.preferences)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

