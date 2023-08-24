//
//  ContentView.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogMainView: View {
//    @StateObject private var dogViewModel = DogVM()
//    @State private var selectedBreed = ""
    
    var body: some View {
        ZStack {
                        
            TabView {
                DogRandomView()
                    .tabItem {
                        Label("Random Dog", systemImage: "list.dash")
                    }
                
                DogBreedView()
                    .tabItem {
                        Label("Breed View", systemImage: "square.and.pencil")
                    }
                
                TestView()
                    .tabItem {
                        Label("Test", systemImage: "tray.2.fill")
                    }
                
                TestView()
                    .tabItem {
                        Label("Test", systemImage: "clipboard.fill")
                    }
            }
        }
    }
}

struct DogMainView_Previews: PreviewProvider {
    static var previews: some View {
        DogMainView()
//            .environmentObject(Test())
    }
}
