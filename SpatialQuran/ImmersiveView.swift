//
//  ImmersiveView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/4/24.
//

import SwiftUI
import RealityKit
struct RealView: View {
    var ayah: Ayah
    var body: some View {
        VStack{
            Model3D(named: "\(objectPositions[ayah.identification()] ?? "kaba")"){model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(objectPositions[ayah.identification()] == "kaba" ? 0.05 : 1)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

