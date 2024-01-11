//
//  PentominoesApp.swift
//  Pentominoes
//
//  Created by Elliott Salvatori on 9/12/23.
//

import SwiftUI

@main
struct PentominoesApp: App {
    @StateObject var manager = GameManager()
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(manager)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.init(red: 0.99, green: 0.94, blue: 0.84))
        }
    }
}
