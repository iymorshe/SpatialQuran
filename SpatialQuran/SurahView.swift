//
//  SurahView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/3/24.
//


import SwiftUI
import RealityKit

struct SurahView: View {
    @ObservedObject var surah: Surah
    @State var pressed: Bool = false
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading){
                    ForEach(surah.ayahs, id: \.self) { ayah in
                        AyahView(ayah:ayah)
                    }
                    
                }
            }
                }
            }
            
        }

#Preview {
    ContentView()
}
