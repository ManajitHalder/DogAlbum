//
//  DogRandomView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogRandomView: View {
    @StateObject var dogViewModel = DogVM()
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    ZStack {
                        Color.gray
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text(dogViewModel.dogBreed)
                                .padding()
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(Color.teal)
                            
                            Image(uiImage: dogViewModel.dogImage)
                                .resizable()
                                .frame(width: 400, height: 450, alignment: .bottom)
                        
                            Button {
                                dogViewModel.fetchDog()
                            } label: {
                                Image(systemName: "arrowshape.turn.up.right.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.teal)
                            }
                        }
                        .padding()
                        .navigationTitle("Dog World")
                        .navigationBarTitleDisplayMode(.automatic)
                        .onAppear {
                            dogViewModel.fetchDog()
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct DogRandomView_Previews: PreviewProvider {
    static var previews: some View {
        DogRandomView()
    }
}
