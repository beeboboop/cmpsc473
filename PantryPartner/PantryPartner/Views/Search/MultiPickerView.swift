//
//  MultiPickerView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/19/23.
//

import SwiftUI

struct MultiPickerView<T:FilterEnumProtocol>: View {
    @Environment(RecipeManager.self) var manager
    let columns = [GridItem(.adaptive(minimum: 100))]
    let pickerType : T.Type
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(T.allCases) { option in
                        Button(action: {
                            manager.toggleSearchParam(foodEnum: option)
                        }) {
                            Text(option.rawValue.localizedCapitalized)
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(.maroon)
                                        .opacity(
                                            manager.searchParametersContain(option) ?
                                            1 : 0.5
                                        )
                                )
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}
