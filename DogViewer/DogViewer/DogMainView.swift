//
//  ContentView.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogMainView: View {
    @StateObject var dogViewModel = DogVM()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Text(dogViewModel.dogBreed)
                    
                    Image(uiImage: dogViewModel.dogImage)
                        .resizable()
                        .foregroundColor(.accentColor)
                        .frame(width: 300, height: 400, alignment: .bottom)
                    
                }
                .padding()
                .navigationTitle("Dog Album")
                .navigationBarTitleDisplayMode(.large)
                .onAppear {
                    dogViewModel.fetchDog()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DogMainView()
    }
}
