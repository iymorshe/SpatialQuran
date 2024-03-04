//
//  SurahView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/3/24.
//


import SwiftUI
import RealityKit
import RealityKitContent

struct SurahView: View {
    @ObservedObject var surah: Surah
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(surah.ayahs, id: \.self) { ayah in
                        Text("\(ayah.ayahNumber). \(ayah.englishTranslation)")
                            .font(.system(size:30))
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
