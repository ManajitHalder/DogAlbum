//
//  DogBreedView.swift
//  
//  Created by Manajit Halder on 13/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogBreedView: View {
    var breeds = ["dog1", "dog2", "dog3", "dog11", "dog12", "dog13", "dog21", "dog22", "dog23", "dog31", "dog32", "dog33"]
    @State private var selectedBreed = "dog1"
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(selectedBreed)
                    .font(.system(size: 36, weight: .bold))
                    .font(.headline)
                    .foregroundColor(.black)
            
                Picker("Select breed", selection: $selectedBreed) {
                    ForEach(breeds, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                
                Spacer()
                
                Image(systemName: "arrowshape.turn.up.right.circle")
                    .resizable()
            }
            .padding()
        }
    }
}

struct DogBreedView_Previews: PreviewProvider {
    static var previews: some View {
        DogBreedView()
    }
}
