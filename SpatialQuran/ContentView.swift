//
//  ContentView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 2/28/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var surahName: String = "The Opening"
    @State var quranText: [Ayah] = []
    @StateObject var quran: Quran = Quran.shared
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("hello")
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text(surahName)
                    .font(.title)
                Button {
                    print("hello")
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            ScrollView {
                ForEach(quranText, id: \.self) { ayah in
                    Text("\(ayah.surahNumber).\(ayah.ayahNumber) \(ayah.englishTranslation)")
                        .padding(10)
                    if ayah.englishTranslation.contains("way") {
                        Model3D(named: "Scene", bundle: realityKitContentBundle)
                            .padding(.bottom, 50)
                    }
                }
            }
            .onAppear {
                Task {
                    await loadVersesForSurah(surahNumber: 1)
                }
            }
        }
    }
    private func loadVersesForSurah(surahNumber: Int) async {
        guard surahNumber - 1 < versesPerChapter.count else { return }
        let numberOfVerses = versesPerChapter[surahNumber]
        var surah = Surah(surahNumber: surahNumber)
        for verseNumber in 1...numberOfVerses {
            do {
                let ayah = try await fetchVerse(surahNumber: surahNumber, verseNumber: verseNumber)
                DispatchQueue.main.async {
                    surah.ayahs.append(ayah)
                    quranText.append(ayah)
                }
                
                
            } catch {
                print("Error fetching verse: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
