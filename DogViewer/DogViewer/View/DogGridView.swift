//
//  DogGridView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogGridView: View {
    @StateObject private var dogViewModel = DogVM()
    @State private var searchText = ""
    @State private var isSearchBarHidden = false // Add a state variable to control the search bar visibility in the current and Detail view.
        
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
            
            VStack {
                if isSearchBarHidden == false {
                    SearchBar()
                }
                
                NavigationView {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(dogViewModel.dogBreedList, id: \.self) { dog in
                                NavigationLink(destination: DogDetailView(isSearchBarHidden: $isSearchBarHidden, name: dog)) {
                                    DogViewer(name: dog)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
//            print("Called from onApper:")
            dogViewModel.fetchBreedList()
//            dogViewModel.fetchDogByBreed(breed: dogViewModel.dogBreed)
            //dogViewModel.fetchRandomDog()
            isSearchBarHidden = false
        }
        .onDisappear {
            isSearchBarHidden = true
        }

    }
}

struct DogViewer: View {
    @StateObject private var dogViewModel = DogVM()
    var name: String
    
    /*
     Following Gradient Colors were generated from website: https://angrytools.com/gradient/
     */
    static let color0 = Color(red: 15/255, green: 13/255, blue: 46/255);
    static let color1 = Color(red: 6/255, green: 82/255, blue: 143/255);
    let gradient = Gradient(colors: [color0, color1]);

    var body: some View {
        VStack {
            Image(uiImage: dogViewModel.dogImage)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 200)
            
            Text(dogViewModel.dogBreed)
                .font(.title2)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundColor(Color.black)

            Rectangle()
                .fill(RadialGradient(
                          gradient: gradient,
                          center: .center,
                          startRadius: 1,
                          endRadius: 100
                        ))
        }
        .onAppear {
            dogViewModel.fetchRandomDog()
        }
    }
}

struct DogDetailView: View {
    @Binding var isSearchBarHidden: Bool
    
    var name: String
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
        }
        .onAppear {
            isSearchBarHidden = true
        }
        .onDisappear {
            isSearchBarHidden = false
        }
    }
}

struct DogGridView_Previews: PreviewProvider {
    static var previews: some View {
        DogGridView()
    }
}
