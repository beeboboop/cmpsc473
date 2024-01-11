//
//  LetterButtonsView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct LetterButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    let radius : CGFloat = 80
    var body: some View {
        let numLetters : Int = gameManager.game.letters.count
        ZStack {
            LetterButton(shape: ButtonShape(numLetters: numLetters), char: gameManager.game.mustHaveLetter, angle: Angle())
            ForEach(1..<numLetters, id: \.self) { index in
                let angle = CGFloat(index) * (2*CGFloat.pi)/CGFloat(numLetters-1) + CGFloat.pi/2
                LetterButton(shape: ButtonShape(numLetters: gameManager.preferences.numberOfLetters.value), char: gameManager.game.letters[index], angle: Angle(radians: angle*2))
                    .offset(x: radius * cos(angle), y: radius * sin(angle))
            }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LetterButtonsView()
    }
}

struct LetterButton<Content:Shape>: View {
    @EnvironmentObject var gameManager : GameManager
    let shape : Content
    let char : Character
    let angle : Angle
    var body: some View {
        Button(action: {gameManager.enterLetter(char: char)}) {
            ZStack {
                shape
                    .rotation(angle)
                    .frame(width: 70, height: 70)
                    .foregroundColor(char == gameManager.game.mustHaveLetter ? .yellow : .blue)
                Text(String(char))
                    .foregroundColor(.white)
                    .font(.title2)
                    .bold()
            }
        }.contentShape(shape)
    }
}
