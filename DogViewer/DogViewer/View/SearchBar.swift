//
//  SearchBarView.swift
//  
//  Created by Manajit Halder on 26/09/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("dog breed", text: $searchText)
                
                Image(systemName: "mic.fill")
                
                Image(systemName: "camera.metering.spot")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.25), lineWidth: 3)
            )
            .padding()
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
            .previewLayout(.fixed(width: .infinity, height: 40))
    }
}
