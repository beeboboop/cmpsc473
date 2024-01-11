//
//  MenuButtonsView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct MenuButtonsView: View {
    @Binding var showing: Showing?
    
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        HStack() {
            Spacer()
            MenuButton(systemImageName: "restart", action: {gameManager.restart()})
            Spacer()
            MenuButton(systemImageName: "shuffle", action: {gameManager.shuffle()})
            Spacer()
            MenuButton(systemImageName: "lightbulb", action: {showing = .hints})
            Spacer()
            MenuButton(systemImageName: "gear", action: {showing = .preferences})
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.gray)
    }
}

struct MenuButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        MenuButtonsView(showing: .constant(.hints))
    }
}

struct MenuButton: View {
    let systemImageName: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemImageName)
                .font(.title2)
                .padding()
                .foregroundColor(.white)
        }
    }
}
