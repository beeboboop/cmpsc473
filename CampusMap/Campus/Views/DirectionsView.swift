//
//  DirectionsView.swift
//  Campus
//
//  Created by Elliott Salvatori on 10/8/23.
//

import SwiftUI
import MapKit

struct DirectionsView: View {
    @Environment(MapManager.self) var manager
    @State private var horizOffset : CGFloat = 0
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                if manager.nextStep == nil && value.translation.width < 0 {
                    horizOffset = value.translation.width/4
                }
                else if manager.prevStep == nil && value.translation.width > 0 {
                    horizOffset = value.translation.width/4
                }
                else {
                    horizOffset = value.translation.width
                }
            }
            .onEnded {value in
                if manager.prevStep != nil && value.translation.width > 10 {
                    manager.currentStep = manager.prevStep
                    horizOffset = -horizOffset
                }
                if manager.nextStep != nil && value.translation.width < -10 {
                    manager.currentStep = manager.nextStep
                    horizOffset = -horizOffset
                }
                withAnimation {
                    horizOffset = 0
                }
            }
        if let currentStep = manager.currentStep {
            ZStack {
                Text(currentStep.instructions)
                    .offset(x: horizOffset, y: 0)
                    .opacity(horizOffset == 0 ? 1 : 50/horizOffset.magnitude)
                    .frame(width:300, height: 20)
                    .foregroundStyle(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray).opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .gesture(dragGesture)
                Button(action: {
                    manager.clearDirections()
                }) {
                    Image(systemName: "xmark")
                        .frame(width: 15, height: 15)
                }
                .clipShape(.circle)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .offset(x: 165, y: -25)
            }
        }
    }
}
