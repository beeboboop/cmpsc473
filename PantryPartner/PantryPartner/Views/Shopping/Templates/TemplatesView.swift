//
//  TemplatesView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/8/23.
//

import SwiftUI
import SwiftData

struct TemplatesView: View {
    @Environment(\.modelContext) var context
    
    @State private var isAdding : Bool = false
    
    @Query private var templates : [ShoppingTemplate] = []
    
    let columns = [GridItem(.adaptive(minimum: 175))]
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                if templates.isEmpty {
                    EmptyContentView(labelText: "You don't have any templates",
                                     imageName: "face.dashed",
                                     description: "Press the \"+\" button to create a shopping list template")
                }
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(templates) { template in
                        TemplateTile(template: template)
                    }
                }
            }
            .navigationTitle("Shopping Templates")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(imageName: "plus.circle.fill", backgroundColor: .orangeButton, action: {isAdding.toggle()})
                }
            }
        }
        .sheet(isPresented: $isAdding) {
            AddTemplateView(adding: addTemplate(_:))
        }
    }
}

#Preview {
    TemplatesView()
        .modelContainer(for: [PantryItem.self, ShoppingTemplate.self], inMemory: true)
}

extension TemplatesView {
    func addTemplate(_ name: String) {
        let template = ShoppingTemplate(name: name, items: [])
        context.insert(template)
    }
    
}
