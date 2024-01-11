//
//  ActionButton.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/14/23.
//

import SwiftUI

struct ActionButton : View {
    let text : String
    let color : Color
    let action : () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Text(text)
                    .font(.title2).bold()
                    .foregroundColor(color)
                    .padding()
                    .overlay(
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(color, lineWidth: 2)
                            RoundedRectangle(cornerRadius: 15)
                                .fill(color)
                                .opacity(0.30)
                        }
                    )
            }
        }
    }
}
