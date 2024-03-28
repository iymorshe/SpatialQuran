//
//  ImmersiveView.swift
//  SpatialQuran
//
//  Created by Iman Morshed on 3/4/24.
//

import SwiftUI
import RealityKit
import RealityKitContent
struct ImmersiveView: View {
    var body: some View {
        VStack{
            Text("Salama")
            Model3D(named: "kaba"){model in
                model
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Text("Habibi")
            }
        }
    }
}

#Preview {
    ImmersiveView()
}
