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
//    @State private var items = ["Apple", "Banana", "Cherry", "Date", "Fig", "Grapes"]
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
            
            VStack {
                if isSearchBarHidden == false {
                    SearchBar(text: $searchText)
//                    List {
//                        ForEach(items, id: \.self) { dog in
//                            Text(dog)
//                        }
//                    }
                }
                
                NavigationView {
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(dogViewModel.dogDetail.breedList, id: \.self) { dog in
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

//        func filteredDogs() -> [String] {
//            // Replace this with your own data and filtering logic
//            return searchText.isEmpty ? items : items.filter { $0.lowercased().contains(searchText.lowercased()) }
//        }
    }
}

struct DogViewer: View {
    @StateObject private var dogViewModel = DogVM()
    var name: String
//    var dogList: [String] = []
    
    /*
     Following Gradient Colors were generated from website: https://angrytools.com/gradient/
     */
    static let color0 = Color(red: 177/255, green: 176/255, blue: 174/255);
    static let color1 = Color(red: 112/255, green: 113/255, blue: 61/255);
    static let color2 = Color(red: 186/255, green: 190/255, blue: 186/255);
    let gradient = Gradient(colors: [color0, color1, color2]);

    
    var body: some View {
        VStack(spacing: 8) {
            
            Image(uiImage: dogViewModel.dogDetail.image)
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
            
            Text(name)
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
            dogViewModel.fetchDogByBreed(breed: name)
//            dogViewModel.fetchRandomDog()
//            dogViewModel.fetchBreedList()
//            print(dogViewModel.dogDetail.breedList)
//            self.dogList = dogViewModel.dogBreedList
        }
    }
}


struct DogGridView_Previews: PreviewProvider {
    static var previews: some View {
        DogGridView()
    }
}
