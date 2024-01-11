//
//  BuildingListSheet.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/2/23.
//

import SwiftUI
import MapKit

struct BuildingListSheet: View {
    @Environment(MapManager.self) var manager
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack{
                Menu("Filter Results") {
                    Button(action: {manager.filterOption = .all}) {
                        HStack {
                            Image(systemName: manager.filterOption == .all ? "checkmark.square" : "square")
                            Text("All Buildings")
                        }
                    }
                    Button(action: {manager.filterOption = .favorited}) {
                        HStack {
                            Image(systemName: manager.filterOption == .favorited ? "checkmark.square" : "square")
                            Text("Favorited Buildings")
                        }
                    }
                    Button(action: {manager.filterOption = .selected}) {
                        HStack {
                            Image(systemName: manager.filterOption == .selected ? "checkmark.square" : "square")
                            Text("Selected Buildings")
                        }
                    }
                    Button(action: {manager.filterOption = .nearby}) {
                        HStack {
                            Image(systemName: manager.filterOption == .nearby ? "checkmark.square" : "square")
                            Text("Nearby Buildings")
                        }
                    }
                }.padding()
                Spacer()
                Button("Dismiss") {
                    dismiss()
                }.padding()
            }
            NavigationStack {
                List {
                    ForEach(searchResults) {building in
                        Button(action: {manager.toggleSelectionOf(building)}) {
                            HStack {
                                Image(systemName: building.isSelected ? "checkmark.square" : "square")
                                    .foregroundStyle(building.isSelected ? .blue : .gray)
                                Text(building.name)
                                    .foregroundStyle(building.isSelected ? .blue : .gray)
                                Spacer()
                                if building.isFavorited {
                                    Image(systemName: "heart.fill")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Campus Buildings")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for building")
            }
        }

        
        var searchResults: [Building] {
            if searchText.isEmpty {
                return manager.filteredBuildings
            } else {
                return manager.filteredBuildings.filter {$0.name.contains(searchText)}
            }
        }
    }
}
