//
//  ContentView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 2/28/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State var surahNumber: Int = 1
    @State var quranText: [Ayah] = []
    @ObservedObject var quran: Quran = Quran.shared
    var body: some View {
        NavigationSplitView{
            VStack{
                HStack {
                    Button {
                        if surahNumber > 1 {
                            surahNumber -= 1
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    Pick(selectedSurah: $surahNumber)
                    Button {
                        surahNumber += 1
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
            Spacer()
        }
    detail: { VStack {
        SurahView(surah: quran.surahs[surahNumber])
        
            .onAppear {
                    Task {
                        await Quran.shared.loadVersesForSurah(surahNumber: surahNumber)
                    }
            }
    }
    }
    }
        

    }

