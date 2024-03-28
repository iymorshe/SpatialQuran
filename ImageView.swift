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
        RealityView { content in
            do {
                let immersiveEntity = try await Entity(named:"Immersive", in: realityKitContentBundle)
                content.add(immersiveEntity)
            } catch {
                print("\(error)")
            }
        }
            
    }
}

#Preview {
    ImageView()
}
