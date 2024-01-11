//
//  EditingButtonsView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct EditingButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        HStack() {
            TextEditButton(systemImageName: "delete.left", action: {gameManager.delete()})
                .disabled(gameManager.currentWord.isEmpty)
            Spacer()
            TextEditButton(systemImageName: "return.left", action: {gameManager.submitWord()})
                .foregroundColor(gameManager.isCurrentWordValid ? .green : nil)
                .disabled(!gameManager.isCurrentWordValid)
                
        }
    }
}

struct EditingButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        EditingButtonsView()
    }
}

struct TextEditButton: View {
    let systemImageName: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .font(.largeTitle)
                .padding()
        }
    }
}
