//
//  ContentView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/1/23.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            PantryView()
                .tabItem {
                    Label("Pantry", systemImage: "list.bullet")
                }
            ShoppingView()
                .tabItem {
                    Label("Shopping", systemImage: "basket")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

#Preview {
    RootView()
        .environment(RecipeManager())
}
