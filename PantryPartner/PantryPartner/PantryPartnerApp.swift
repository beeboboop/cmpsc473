//
//  PantryPartnerApp.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/1/23.
//

import SwiftUI
import SwiftData

@main
struct PantryPartnerApp: App {
    @State var manager = RecipeManager()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: [PantryItem.self, ShoppingTemplate.self])
                .environment(manager)
                .onChange(of: scenePhase) {oldValue, newValue in
                    switch newValue {
                    case .background:
                        manager.persister.save(manager.user)
                    default:
                        break
                    }
                }
        }
    }
}
