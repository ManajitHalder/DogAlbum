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
    static let color0 = Color(red: 177/255, green: 176/255, blue: 174/255);
    static let color1 = Color(red: 112/255, green: 113/255, blue: 61/255);
    static let color2 = Color(red: 186/255, green: 190/255, blue: 186/255);
    let gradient = Gradient(colors: [color0, color1, color2]);

    var body: some View {
        VStack(spacing: 8) {
            Image(uiImage: dogViewModel.dogImage)
                .resizable()
                .frame(maxWidth: .infinity)
                .frame(height: 260)
            
            Rectangle()
                    .fill(LinearGradient(
                      gradient: gradient,
                      startPoint: .init(x: 0.00, y: 0.50),
                      endPoint: .init(x: 1.00, y: 0.50)
                    ))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 3)
                    .padding(.top, -10)
            
            Text(dogViewModel.dogBreed)
                .font(.title2)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .foregroundColor(Color.black)

            Rectangle()
                    .fill(LinearGradient(
                      gradient: gradient,
                      startPoint: .init(x: 0.00, y: 0.50),
                      endPoint: .init(x: 1.00, y: 0.50)
                    ))
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 3)
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
            VStack {
                Text("Dog Detail View")
            }
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
