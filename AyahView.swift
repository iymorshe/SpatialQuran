//
//  AyahView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/30/24.
//

import SwiftUI

struct AyahView: View {
    @ObservedObject var quran = Quran.shared
    @State var ayah: Ayah
    @State var showed: Bool = false
    var body: some View {
        HStack{
            Text("\(ayah.ayahNumber). \(ayah.englishTranslation)")
                .font(.system(size:30))
            Spacer()
            /*Button(action: {
                withAnimation {
                    quran.toggleFavorite(ayah: ayah)
                }
            }) {
                Image(systemName: quran.isFavorite(ayah: ayah) ? "star.fill" : "star")
                    .foregroundColor(quran.isFavorite(ayah: ayah) ? .yellow : .gray)
                
            } */
        }
            if objectPositions.contains(where: {$0.key == ayah.identification()}) {
                VStack{
                    HStack{
                        Spacer()
                        Button("See Object") {
                            showed.toggle()
                        }
                        .padding()
                        .glassBackgroundEffect()
                        Spacer()
                    }
                    if showed{
                        RealView(ayah:ayah)
                    }
                    
                    
                }
            }}
    }
