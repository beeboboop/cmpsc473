//
//  AddItemView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name : String = ""
    @State private var description : String = ""
    @State private var amount : Int = 1
    
    let isShoppingListItem : Bool
    let adding : (String, String, Int) -> Void
    let title : String
    
    var body: some View {
        ZStack {
            Color.background2.ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                TextField("Product Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                TextField("Product Description", text: $description)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    Text("Quantity: ")
                    QuantityStepper(amount: $amount)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        adding(name, description, amount)
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
            .presentationDetents([.fraction(0.4)])
            .padding()
        }
    }
}
