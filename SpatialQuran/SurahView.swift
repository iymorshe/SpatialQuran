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
    @State var pressed: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(surah.ayahs, id: \.self) { ayah in
                        Text("\(ayah.ayahNumber). \(ayah.englishTranslation)")
                            .font(.system(size:30))
                        if objectPositions.contains(where: {$0.key == ayah.identification()}) {
                            VStack{
                                HStack{
                                    Spacer()
                                    
                                    Button("See Object") {
                                        pressed.toggle()
                                    }
                                    
                                    .padding()
                                    .glassBackgroundEffect()
                                    Spacer()
                                }
                                if pressed {
                                    Model3D(named: "street") {
                                        model in
                                        model
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .scaleEffect(0.7)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                }
                }
            }
            
        }
    }

#Preview {
    ContentView()
}
