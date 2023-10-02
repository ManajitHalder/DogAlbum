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
                    CustomDogImageView(dogImage: dogViewModel.dogDetail.image)
                        .padding()
                    
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

struct CustomDogImageView: View {
    var dogImage: UIImage
    @State private var isImageLoaded = false
    
    var body: some View {
        ZStack {
            if isImageLoaded {
                Image(uiImage: dogImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 350, maxHeight: 350)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.accentColor, lineWidth: 2))
                    .shadow(radius: 5)
                    .mask(RoundedRectangle(cornerRadius: 20))
                    .transition(.opacity) // Apply a fade-in transition
            } else {
                ProgressView() // Show a loading spinner while the image is loading
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .frame(width: 350, height: 350)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Simulate image loading for 2 seconds
                isImageLoaded = true
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isImageLoaded) // Apply a fade-in animation
    }
}

struct DogDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DogDetailView(isSearchBarHidden: .constant(true), name: "")
    }
}
