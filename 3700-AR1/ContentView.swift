//
//  ContentView.swift
//  3700-AR1
//
//  Created by Vladislav Luchnikov on 2021-02-04.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    @State private var isWalkthroughViewShowing = true
    @State private var showInfo: Bool = false
    
    var body: some View {
        Group{
            if isWalkthroughViewShowing{
                WalkthroughView(isWalkthroughViewShowing: $isWalkthroughViewShowing)
            } else {
                ARViewContainer().edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                ControlView(showInfo: $showInfo)
                    
                
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
