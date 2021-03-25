//
//  GradientView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

import SwiftUI

struct GradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
                                            Color(#colorLiteral(red: 1, green: 0.381138593, blue: 0.004580819979, alpha: 1)),
                                            Color(#colorLiteral(red: 0.9943681359, green: 0.4980443716, blue: 0.1695303619, alpha: 1)),
                                            Color(#colorLiteral(red: 0.9958040118, green: 0.5750765204, blue: 0.2727994323, alpha: 1)),
                                            Color(#colorLiteral(red: 0.9957335591, green: 0.6547590494, blue: 0.3987440467, alpha: 1)),
                                            Color(#colorLiteral(red: 0.987564981, green: 0.7175361514, blue: 0.4674369097, alpha: 1)),
                                                    ]
        ), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}

