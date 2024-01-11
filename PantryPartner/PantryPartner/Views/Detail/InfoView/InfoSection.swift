//
//  InfoSection.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/21/23.
//

import SwiftUI

struct InfoSection: View {
    let title : String
    let text : String
    var url : String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title2)
                Spacer()
            }
            if let url {
                Link(text,
                     destination: URL(string: url)!)
            } else {
                Text(text)
            }
        }
    }
}
