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
    @StateObject var quran: Quran = Quran.shared
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
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(quranText, id: \.self) { ayah in
                        Text("\(ayah.ayahNumber). \(ayah.englishTranslation)")
                            .font(.system(size:30))
                        Spacer()
                        //                    if ayah.englishTranslation.contains("way") {
                        //                        Model3D(named: "Scene", bundle: realityKitContentBundle)
                        //                            .padding(.bottom, 50)
                        //                    }
                    }
                }
            }
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
        for verseNumber in 1...numberOfVerses {
            do {
                let ayah = try await fetchVerse(surahNumber: surahNumber, verseNumber: verseNumber)
                DispatchQueue.main.async {
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
