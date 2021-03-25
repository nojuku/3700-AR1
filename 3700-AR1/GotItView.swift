//
//  GotItView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

import SwiftUI

struct GotItView: View {
    @Binding var isWalkthroughViewShowing: Bool
    
    var body: some View {
        Button(action: { dismiss() }, label: {
            Text("Got it!")
                .foregroundColor(.white)
                .underline()
                .padding(.bottom)
        })
    }
    
    func dismiss() {
        withAnimation{
            isWalkthroughViewShowing.toggle()
        }
    }
}

struct GotItView_Previews: PreviewProvider {
    static var previews: some View {
        GotItView(isWalkthroughViewShowing: Binding.constant(true))
    }
}

