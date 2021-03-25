//
//  WalkthroughView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

import SwiftUI

struct WalkthroughView: View {
    @State private var selection = 0
    @Binding var isWalkthroughViewShowing: Bool
    var body: some View {
        ZStack {
            GradientView()
            
            VStack {
                PageTabView(selection: $selection)
                ButtonsView(selection: $selection)
                GotItView(isWalkthroughViewShowing: $isWalkthroughViewShowing)
            }
            
        }
        .transition(.move(edge: .bottom))
    }
}

struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView(isWalkthroughViewShowing: Binding.constant(true))
    }
}

