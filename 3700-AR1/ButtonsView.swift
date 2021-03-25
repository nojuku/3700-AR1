//
//  ButtonsView.swift
//  Welcome Page
//
//  Created by Keeley Litzenberger on 2021-03-18.
//

import SwiftUI

struct ButtonsView: View {
    @Binding var selection: Int
    let buttons = ["Previous", "Next"]
    
    
    var body: some View {
        HStack {
            ForEach(buttons, id: \.self) {buttonLabel in
                Button(action: {buttonAction(buttonLabel)}, label: {
                    Text(buttonLabel)
                        .fontWeight(.heavy)
                        .padding()
                        .frame(width: 150, height: 44)
                        .background(Color.black.opacity(0.27))
                        .cornerRadius(12)
                        .padding(.horizontal)
                })
            }
        }
        .foregroundColor(.white)
        .padding()
    }
    
    func buttonAction(_ buttonLabel: String) {
        withAnimation {
            if buttonLabel == "Previous" && selection > 0 {
                selection -= 1
            } else if buttonLabel == "Next" && selection < tabs.count - 1 {
                selection += 1
            }
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView(selection: Binding.constant(0))
    }
}

