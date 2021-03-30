//
//  InfoView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-23.
//

import SwiftUI

struct InfoView: View {
    @Binding var showInfo: Bool

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Image("ewaste")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .padding()
            .navigationBarTitle(Text("Info"), displayMode: .automatic)
            .navigationBarItems(trailing:
                Button(action: {
                    self.showInfo.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}

