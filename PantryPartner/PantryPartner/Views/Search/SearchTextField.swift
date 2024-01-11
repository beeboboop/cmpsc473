//
//  SearchTextField.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var searchString : String
    var isTyping : FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            TextField("Search...", text: $searchString)
                .focused(isTyping)
            Spacer()
            if !searchString.isEmpty {
                Button(action: {
                    searchString = ""
                    isTyping.wrappedValue = true
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundStyle(.gray)
                }
            }
        }
            .padding(8)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
    }
}
