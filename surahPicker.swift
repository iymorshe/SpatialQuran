//
//  surahPicker.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 4/2/24.
//

import SwiftUI


struct surahPicker: View {
    @State private var selectedSurahIndex: Int
    let labelText: String
    @Binding var selectedSurah: Int // Added binding variable
    @Binding var validStart: Int // Added validStart parameter
    
    init(labelText: String, selectedSurah: Binding<Int>, validStart: Binding<Int>) {
        self.labelText = labelText
        self._selectedSurah = selectedSurah
        self._selectedSurahIndex = State(initialValue: selectedSurah.wrappedValue)
        self._validStart = validStart}

    var body: some View {
        Form {
            Section() {
                Picker(labelText, selection: $selectedSurahIndex) {
                    ForEach(1..<validStart+1, id: \.self) { index in
                        Text("\(index). \(surahNames[index])")
                    }
                }
            }
        }
        .onChange(of: selectedSurahIndex) {
            selectedSurah = selectedSurahIndex // Update the binding variable
        }
    }
}
