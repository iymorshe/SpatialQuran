//
//  SpatialQuranApp.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 2/28/24.
//

import SwiftUI

@main
struct SpatialQuranApp: App {
    
    @StateObject var quran = Quran.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
          .environmentObject(quran)
        }
    }
}
