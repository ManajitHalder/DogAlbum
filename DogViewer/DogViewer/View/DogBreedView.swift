//
//  DogBreedView.swift
//  
//  Created by Manajit Halder on 13/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogBreedView: View {
    @StateObject private var dogViewModel = DogVM()
        
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.05)
            
            VStack {
                Text(dogViewModel.dogBreed)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
            
                Picker("Select breed", selection: $dogViewModel.dogBreed) {
                    ForEach(dogViewModel.dogBreedList, id: \.self) {
                        Text($0)
                    }
                }
                .onChange(of: dogViewModel.dogBreed) { newBreed in
                    print("Called from onChange:")
                    dogViewModel.fetchDogByBreed(breed: newBreed)
//                    dogSelected(dogViewModel.dogBreed)
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Image(uiImage: dogViewModel.dogImage)
                    .resizable()
                    .frame(maxWidth: 450, maxHeight: 500)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.black.opacity(0.5), lineWidth: 2)
                    )
            }
            .padding()
        }
        .onAppear {
            print("Called from onApper:")
            dogViewModel.fetchBreedList()
            dogViewModel.fetchDogByBreed(breed: dogViewModel.dogBreed)
        }
    }
    
//    func dogSelected(_ option: String) {
//        dogViewModel.dogBreed = option
//    }
}

struct DogBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedView()
    }
}
