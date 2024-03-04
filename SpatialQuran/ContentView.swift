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
    @State var surahNumber: Int = 1
    @State var quranText: [Ayah] = []
    @ObservedObject var quran: Quran = Quran.shared
    var body: some View {
        VStack {
            HStack {
                Button {
                    if surahNumber > 1 {
                        surahNumber -= 1
                        Task {
                            await loadVersesForSurah(surahNumber: surahNumber)
                        }
                    }
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text(englishSurahNames[surahNumber])
                    .font(.title)
                    .fontWeight(.bold)
                Button {
                    surahNumber += 1
                    Task {
                        await loadVersesForSurah(surahNumber: surahNumber)
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            SurahView(surah: quran.surahs[surahNumber])

            .onAppear {
                Task {
                    await loadVersesForSurah(surahNumber: surahNumber)
                }
            }
        }
    }
    private func loadVersesForSurah(surahNumber: Int) async {
        guard surahNumber - 1 < versesPerChapter.count else { return }
        let numberOfVerses = versesPerChapter[surahNumber]
        quranText = []
        if (Quran.shared.surahs[surahNumber].ayahs.count != 0) {
            return
        }
        for verseNumber in 1...numberOfVerses {
            do {
                let ayah = try await fetchVerse(surahNumber: surahNumber, verseNumber: verseNumber)
                DispatchQueue.main.async {
                    //quranText.append(ayah)
                    withAnimation{ Quran.shared.surahs[surahNumber].ayahs.append(ayah)
                    }
                }
                Quran.shared.surahs[surahNumber].sortAyahs()
            } catch {
                print("Error fetching verse: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
