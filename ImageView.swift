//
//  ImageView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/6/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImageView: View {
//    @State var itemEntity: Entity = {
//        let groundAnchor = AnchorEntity(
//    }
    var body: some View {
        
        RealityView{ content in
            if let s = try? await Entity(named: "kaba"){
                content.add(s)
            }
        }
            
    }
}

#Preview {
    ImageView()
}
