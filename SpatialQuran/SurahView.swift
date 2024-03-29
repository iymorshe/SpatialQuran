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
                                Button("See Object") {
                                    pressed.toggle()
                                }
                            }
                        }
                }
                Model3D(named: "kaba") {
                    path in
                    path
                        .resizable()
                        .scaleEffect(CGSize(width: 0.05, height: 0.05))
                } placeholder: {
                    Text("Loading")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
