//
//  DetailCard.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/20/23.
//

import SwiftUI

struct DetailCard<T:DetailCardProtocol>: View {
    let title : String
    let details : [T]
    @Binding var isExpanded : Bool
    let color : Color
    
    var imageName : String {
        isExpanded ? "chevron.down" : "chevron.up"
    }
    var body: some View {
        ZStack(alignment: .topLeading) {
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20, topTrailing: 20))
                .fill(color)
                .shadow(radius: 8, y: -2)
                .ignoresSafeArea(edges: .bottom)
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 20, topTrailing: 20))
                .stroke(lineWidth: 1)
                .ignoresSafeArea(edges: .bottom)
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title2)
                    Spacer()
                    Image(systemName: imageName)
                        .foregroundStyle(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isExpanded.toggle()
                }
                .padding(.bottom)
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        ForEach(details) { detail in
                            HStack(alignment: .top) {
                                Text(detail.bulletStyle)
                                Text(detail.displayName)
                                Spacer()
                            }
                            .font(.title3)
                            .padding(.bottom)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    DetailCard(title: "Ingredients", details: Recipe.standard.recipeDetails!.analyzedInstructions.first!.steps, isExpanded: .constant(true), color: Color.background2)
}
