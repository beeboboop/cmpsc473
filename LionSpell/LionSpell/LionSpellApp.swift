//
//  LionSpellApp.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 8/28/23.
//

import SwiftUI

@main
struct LionSpellApp: App {
    @StateObject var gameManager = GameManager(preferences: Preferences())
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(gameManager)
        }
    }
}
