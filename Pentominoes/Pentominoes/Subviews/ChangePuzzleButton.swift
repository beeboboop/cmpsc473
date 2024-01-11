//
//  BoardButton.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct ChangePuzzleButton : View {
    let image : String
    let action : () -> Void
    var body: some View {
        Button(action: action) {
            Image(image)
                .resizable()
                .border(.black, width: 2)
        }
        .frame(width: 100, height: 100)
    }
}
