import SwiftUI

struct Pick: View {
    
    @ObservedObject var quran: Quran = Quran.shared
    @Binding var selectedSurah: Int
    var body: some View {
        Picker("Hamood", selection: $selectedSurah) {
            ForEach(1..<englishSurahNames.count, id: \.self) { index in
                Text("\(index). \(englishSurahNames[index])")
            }
        }
        .onChange(of: selectedSurah) { newValue in
            selectedSurah = newValue // Update the binding variable
            
            Task {
                await quran.loadVersesForSurah(surahNumber: selectedSurah)
            }
        }
    }
}

