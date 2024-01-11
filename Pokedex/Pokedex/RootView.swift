//
//  RootView.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/25/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PokemonList()
                .tabItem {
                    Label("Pokedex", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    RootView()
}
