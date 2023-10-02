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
                .opacity(0.45)
            
            VStack {
                Text(dogViewModel.dogDetail.breed)
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.accentColor)
            
                Picker("Select breed", selection: $dogViewModel.dogDetail.breed) {
                    ForEach(dogViewModel.dogDetail.breedList, id: \.self) {
                        Text($0)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                }
                .onChange(of: dogViewModel.dogDetail.breed) { newBreed in
                    print("Called from onChange:")
                    dogViewModel.fetchDogByBreed(breed: newBreed)
//                    dogSelected(dogViewModel.dogBreed)
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Image(uiImage: dogViewModel.dogDetail.image)
                    .resizable()
                    .frame(maxWidth: 450, maxHeight: 600)
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
            //dogViewModel.fetchDogByBreed(breed: dogViewModel.dogDetail.breed)
        }
    }
}

struct DogBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedView()
    }
}
