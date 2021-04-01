//
//  PageTabView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

import SwiftUI

struct PageTabView: View {
    @Binding var selection: Int
    
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView(selection: $selection) {
                ForEach(tabs.indices, id: \.self){ index in
                    TabDetailsView(index: index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
    }
}

struct PageTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            GradientView()
            PageTabView(selection: Binding.constant(0))
        }
    }
}
