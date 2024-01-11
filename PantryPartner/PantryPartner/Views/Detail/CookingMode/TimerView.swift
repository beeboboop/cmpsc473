//
//  TimerView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct TimerView: View {
    @Environment(RecipeManager.self) var manager
    @Binding var isActive : Bool
    let startTime : Int
    @Binding var elapsedTime : Int
    
    var timeRemaining : Int {
        if elapsedTime < startTime {
            startTime - elapsedTime
        } else {
            0
        }
    }
    var fractionComplete : Double {
        Double(elapsedTime)/Double(startTime)
    }
    
    var body: some View {
        if isActive {
            Text(manager.secondsFormatted(timeRemaining))
                .fontDesign(.monospaced)
                .foregroundStyle(Color.maroon)
                .padding()
                .background(
                    ZStack {
                        Circle()
                            .fill(Color.maroon)
                            .opacity(0.2)
                            .blur(radius: 4)
                        Circle()
                            .trim(from: 0, to: 1-fractionComplete)
                            .stroke(Color.maroon, lineWidth: 2)
                            .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
                            .rotation3DEffect(Angle(degrees: 90), axis: (x: 0, y: 0, z: 1))
                    }
                )
        } else {
            Text("")
                .padding()
                .background(
                    Circle()
                        .opacity(0)
                )
        }
    }
}

#Preview {
    TimerView(isActive: .constant(true), startTime: 300, elapsedTime: .constant(40))
        .environment(RecipeManager())
}
