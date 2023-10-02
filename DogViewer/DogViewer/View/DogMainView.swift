//
//  ContentView.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct SliderTab: View {
    var body: some View {
        Image("slider")
            .resizable()
            .frame(width: 200, height: 200)
    }
}

struct DogMainView: View {
    
    var body: some View {
        ZStack {
                        
            TabView {
                DogRandomView()
                    .tabItem {
                        Label("Random", systemImage: "arrow.triangle.2.circlepath")
                    }
                
                DogBreedView()
                    .tabItem {
                        Label("Breed", systemImage: "list.bullet.below.rectangle")
                    }
                
                DogGridView()
                    .tabItem {
                        Label("Grid", systemImage: "rectangle.grid.1x2")
                    }
            }
        }
    }
}

struct DogMainView_Previews: PreviewProvider {
    static var previews: some View {
        DogMainView()
    }
}
