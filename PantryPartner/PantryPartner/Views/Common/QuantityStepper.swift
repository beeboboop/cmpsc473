//
//  QuantityStepper.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 12/7/23.
//

import SwiftUI

struct QuantityStepper: View {
    @Binding var amount : Int
    var body: some View {
        HStack {
            IconButton(imageName: "minus.circle.fill",
                       backgroundColor: .orangeButton,
                       action: {decrementQty()})
            Text("\(amount)")
                .fontDesign(.monospaced)
            IconButton(imageName: "plus.circle.fill",
                       backgroundColor: .orangeButton,
                       action: {incrementQty()})
        }
    }
}

#Preview {
    QuantityStepper(amount: .constant(5))
}

extension QuantityStepper {
    func incrementQty() {
        if amount < 99 {
            amount += 1
        }
    }
    
    func decrementQty() {
        if amount > 0 {
            amount -= 1
        }
    }
}
