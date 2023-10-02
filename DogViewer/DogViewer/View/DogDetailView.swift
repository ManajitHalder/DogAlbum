//
//  DogDetailView.swift
//  
//  Created by Manajit Halder on 02/10/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogDetailView: View {
    @Binding var isSearchBarHidden: Bool
    @StateObject private var dogViewModel = DogVM()
    var name: String
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
            
            ScrollView {
                VStack {
                    ZStack {
                        Circle()
                            .fill(.red)
                            .padding()
                            .frame(width: 400, height: 400)
                            
                        Image(uiImage: dogViewModel.dogDetail.image)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    Text(name)
                        .padding(.bottom, 10)
                        .font(.custom("Cochin", size: 40))
                        .minimumScaleFactor(0.3)
                        .shadow(radius: 2, x: 3, y: 3)
                    
                    Text("origin")
                    Text("India, North Andaman")
                        .padding(.bottom, 10)
                        .font(.custom("Cochin", size: 30))
                        .minimumScaleFactor(0.3)
                        .shadow(radius: 2, x: 3, y: 3)
                    
                    Text("Description")
                        .padding(.bottom, 10)
                        .font(.custom("Cochin", size: 30))
                        .minimumScaleFactor(0.3)
                        .shadow(radius: 2, x: 3, y: 3)
                    
                    Text("Kuki is a domestic dog with fluppy white hairs on its body. Very naughty and always playful. Sitting style is very attaractive. Kuki is friendly to known people and little uncomfortable with strangers. Sometimes he is seen making unfriendly sounds towards strangers but has never bitten anyone.")
                        .padding([.leading, .trailing, .bottom], 10)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Cochin", size: 25))
                    
                    Text("India, North Andaman")
                        .padding(.bottom, 10)
                        .font(.custom("Cochin", size: 30))
                        .minimumScaleFactor(0.3)
                        .shadow(radius: 2, x: 3, y: 3)
                    
                    Text("Kuki is a domestic dog with fluppy white hairs on its body. Very naughty and always playful. Sitting style is very attaractive. Kuki is friendly to known people and little uncomfortable with strangers. Sometimes he is seen making unfriendly sounds towards strangers but has never bitten anyone.")
                        .padding([.leading, .trailing, .bottom], 10)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Cochin", size: 25))
                    
                    Text("India, North Andaman")
                        .padding(.bottom, 10)
                        .font(.custom("Cochin", size: 30))
                        .minimumScaleFactor(0.3)
                        .shadow(radius: 2, x: 3, y: 3)
                    
                    Text("Kuki is a domestic dog with fluppy white hairs on its body. Very naughty and always playful. Sitting style is very attaractive. Kuki is friendly to known people and little uncomfortable with strangers. Sometimes he is seen making unfriendly sounds towards strangers but has never bitten anyone.")
                        .padding([.leading, .trailing, .bottom], 10)
                        .multilineTextAlignment(.leading)
                        .font(.custom("Cochin", size: 25))
                }
            }
        }
        .onAppear {
            isSearchBarHidden = true
            dogViewModel.fetchDogByBreed(breed: name)
        }
        .onDisappear {
            isSearchBarHidden = false
        }
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(isSearchBarHidden: .constant(true), name: "")
    }
}
