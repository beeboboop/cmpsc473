//
//  HTMLStringView.swift
//  PantryPartner
//
//  Created by Elliott Salvatori on 11/17/23.
//

import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
    let html : String
    let width : CGFloat

    /*func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }*/
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        let data = Data(self.html.utf8)
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            label.attributedText = attributedString
            }
        label.numberOfLines = 10
        label.textAlignment = .center
        label.preferredMaxLayoutWidth = width
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.sizeToFit()
    }
    
}

#Preview {
    HTMLStringView(html: Recipe.standard.recipeDetails?.summary ?? "", width: CGFloat(100))
}
