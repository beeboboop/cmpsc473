//
//  CampusApp.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI

@main
struct CampusApp: App {
    @State var manager = MapManager()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            MainView()
            .environment(manager)
            .onChange(of: scenePhase) { oldValue, newValue in
                switch newValue {
                case .background:
                    manager.save()
                default:
                    break
                }
            }
        }
    }
}
