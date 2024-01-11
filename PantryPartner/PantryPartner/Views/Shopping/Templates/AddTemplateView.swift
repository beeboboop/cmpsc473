//
//  AddTemplateView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/8/23.
//

import SwiftUI

struct AddTemplateView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name : String = ""
    
    let adding : (String) -> Void
    
    var body: some View {
        
        ZStack {
            Color.background2.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("Create template")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                TextField("Template Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Spacer()
                    Button(action: {
                        adding(name)
                        dismiss()
                    }) {
                        Text("Save Item")
                            .font(.title3)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background {
                                Capsule()
                                    .fill(.orangeButton)
                            }
                    }
                    .disabled(name.isEmpty)
                    .opacity(name.isEmpty ? 0.7 : 1)
                    Spacer()
                }
                .padding()
            }
            .presentationDetents([.fraction(0.3)])
            .padding()
        }
    }
}
