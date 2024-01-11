//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Elliott Salvatori on 10/17/23.
//

import SwiftUI

@main
struct PokedexApp: App {
    @Environment(\.scenePhase) var scenePhase
    @State var manager = PokedexManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(manager)
                .onChange(of: scenePhase) {oldValue, newValue in
                    switch newValue {
                    case.background:
                        manager.persister.save(manager.pokemon)
                    default:
                        break
                    }
                }
        }
    }
}
