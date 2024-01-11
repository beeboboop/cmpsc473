//
//  StatText.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/18/23.
//

import SwiftUI

struct StatText: View {
    let title : String
    let stat : Double
    let units : String
    var body: some View {
        VStack {
            Text(title).font(.title3)
            HStack {
                Text(String(format: "%.2f", stat))
                    .font(.largeTitle)
                    .bold()
                Text(units)
                    .font(.title3)
            }
        }
    }
}
