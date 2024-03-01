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
    @State var quranText: [String] = []
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
            ScrollView{
                ForEach(quranText, id: \.self) { q in
                    Text(q)
                        .font(.title)
                        .padding(10)
                }
            }
            
        }
        .onAppear{
            for ayah in 1...versesPerChapter[1] {
                specificQuranVerse(surahNumber: 1, verseNumber: ayah){
                    result in
                    if let result = result {
                        quranText.append(contentsOf: result)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
