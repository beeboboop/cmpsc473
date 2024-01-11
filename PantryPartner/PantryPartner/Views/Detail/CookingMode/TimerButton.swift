//
//  TimerButton.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/24/23.
//

import SwiftUI

struct TimerButton: View {
    @Binding var isActive : Bool
    
    let time : Int
    let unit : String
    
    var text : String {
        "\(time) \(unit)"
    }
    var textColor : Color {
        isActive ? .white : .maroon
    }
    var backgroundColor : Color {
        isActive ? .maroon : .white
    }
    var imageName : String {
        isActive ? "pause.fill" : "play.fill"
    }
    
    var body: some View {
        Button(action: {isActive.toggle()}) {
            HStack {
                Text(text)
                Image(systemName: imageName)
            }
                .foregroundStyle(textColor)
                .padding([.horizontal], 7)
                .padding([.vertical], 3)
                .background(
                    ZStack {
                        Capsule()
                            .fill(backgroundColor)
                        Capsule()
                            .stroke(.maroon)
                    }
                )
        }
    }
}

#Preview {
    TimerButton(isActive: .constant(true), time: 10, unit: "min")
}
