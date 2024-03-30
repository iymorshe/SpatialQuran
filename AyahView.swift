//
//  AyahView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/30/24.
//

import SwiftUI

struct AyahView: View {
    @State var ayah: Ayah
    @State var showed: Bool = false
    var body: some View {
        Text("\(ayah.ayahNumber). \(ayah.englishTranslation)")
            .font(.system(size:30))
        
        if objectPositions.contains(where: {$0.key == ayah.identification()}) {
            let name = objectPositions[ayah.identification()]
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

