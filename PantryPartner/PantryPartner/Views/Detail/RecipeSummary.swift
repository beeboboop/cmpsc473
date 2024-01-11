//
//  RecipeSummary.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI
import AttributedText

struct RecipeSummary: View {
    let strippedSummary : String
    @Binding var lineLimit : Int
    
    var body: some View {
        VStack {
            AttributedText(strippedSummary)
                .font(.caption2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .animation(.easeInOut, value: lineLimit)
        }
    }
}
