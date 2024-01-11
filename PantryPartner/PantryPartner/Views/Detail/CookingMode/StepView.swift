//
//  StepView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/27/23.
//

import SwiftUI

struct StepView: View {
    @Environment(RecipeManager.self) var manager
    let step : RecipeStep
    let stepCount : Int
    
    @Binding var elapsedTime : Int
    @Binding var isTimerActive : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("Step \(step.number)")
                    .foregroundStyle(Color.maroon)
                Text("/ \(stepCount)")
                    .foregroundStyle(Color.gray)
                Spacer()
                if let length = step.length {
                    TimerView(isActive: $isTimerActive, 
                              startTime: manager.secondsFrom(interval: length.number, unit: length.unit),
                              elapsedTime: $elapsedTime)
                } else {
                    TimerView(isActive: .constant(false),
                              startTime: 0,
                              elapsedTime: .constant(0))
                }
            }
            ScrollView(.vertical) {
                HStack {
                    Text(step.step)
                        .font(.title3)
                    Spacer()
                }
                .padding(.bottom)
                if let length = step.length {
                    HStack {
                        TimerButton(isActive: $isTimerActive, 
                                    time: length.number, unit: length.unit)
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}
