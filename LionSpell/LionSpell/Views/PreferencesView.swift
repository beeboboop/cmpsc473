//
//  PreferencesView.swift
//  LionSpell
//
//  Created by Elliott Salvatori on 9/10/23.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var preferences : Preferences
    @Binding var preferencesChanged : Bool
    
    //@State var newPreferences = Preferences()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .trailing) {
            Button("Dismiss")
            {
                dismiss()
            }.padding()
            Form {
                Section("Language") {
                    Picker("Choose", selection: $preferences.language) {
                        ForEach(Language.allCases) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Number of Letters") {
                    Picker("Choose", selection: $preferences.numberOfLetters) {
                        ForEach(NumberOfLetters.allCases) {
                            Text(String($0.value)).tag($0)
                        }
                    }.pickerStyle(.segmented)
                }
            }
            .onChange(of: preferences.language) {_ in
                preferencesChanged = true
            }
            .onChange(of: preferences.numberOfLetters) {_ in
                preferencesChanged = true
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(preferences: .constant(Preferences()), preferencesChanged: .constant(true))
    }
}
