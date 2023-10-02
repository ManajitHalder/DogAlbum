//
//  SearchBarView.swift
//  
//  Created by Manajit Halder on 26/09/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("dog breed", text: $text)
                                
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                
//                Image(systemName: "mic.fill")
//
//                Image(systemName: "camera.metering.spot")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.25), lineWidth: 3)
            )
            .padding()
//            .opacity(text.isEmpty ? 0 : 1)
//            .animation(.default)
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("DFD"))
            .previewLayout(.fixed(width: .infinity, height: 40))
    }
}
