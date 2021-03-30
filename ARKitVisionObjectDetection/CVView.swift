//
//  CVView.swift
//  ARKitVisionObjectDetection
//
//  Created by Vladislav Luchnikov on 2021-03-30.
//  Copyright © 2021 Rozengain. All rights reserved.
//

import SwiftUI

struct CVView: View {
    var body: some View {
        
        CustomController()
    }
}

struct CVView_Previews: PreviewProvider {
    static var previews: some View {
        CVView()
    }
}

struct CustomController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CustomController>) ->  UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "Home")
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomController>) {
        
    }
}
