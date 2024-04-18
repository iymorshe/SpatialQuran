import SwiftUI

struct Pick: View {
    
    @Binding var selectedSurah: Int
    var body: some View {
        Picker("Hamood", selection: $selectedSurah) {
            ForEach(1..<englishSurahNames.count, id: \.self) { index in
                Text("\(index). \(englishSurahNames[index])")
            }
        }
        .onChange(of: selectedSurah) { newValue in
            selectedSurah = newValue // Update the binding variable
        }
    }
}

