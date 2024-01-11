//
//  HeaderView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack() {
            Spacer()
            Spacer()
            Text("Lion")
            Spacer()
            Text("Spell")
            Spacer()
            Spacer()
        }
        .foregroundColor(.white)
        .fontDesign(.monospaced)
        .font(.largeTitle)
        .bold()
        .tracking(10)
        .frame(maxWidth: .infinity)
        .background(.blue)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
