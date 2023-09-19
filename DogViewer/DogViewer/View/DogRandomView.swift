//
//  DogRandomView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogRandomView: View {
    @StateObject private var dogViewModel = DogVM()
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.05)
            
            VStack {
                NavigationView {
                    ZStack {
                        Color.gray
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.05)
                        
                        VStack {
                            Text(dogViewModel.dogBreed)
                                .padding()
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(Color.black)
                                .border(.black, width: 2.5)
                                .cornerRadius(7)
                            
                            Image(uiImage: dogViewModel.dogImage)
                                .resizable()
                                .frame(maxWidth: 450, maxHeight: 500, alignment: .bottom)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black.opacity(0.5), lineWidth: 2)
                                )
                        
                            Button {
                                dogViewModel.fetchRandomDog()
                            } label: {
                                Image(systemName: "arrowshape.turn.up.right.circle")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color.black)
                            }
                        }
                        .padding(.bottom, 10)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Spacer()
                                    Text("Dogs")
                                        .font(.system(size: 35, weight: .bold, design: .serif))
                                    Spacer()
                                }
                            }
                        }
                        .onAppear {
                            dogViewModel.fetchRandomDog()
                        }
                    }
                }
                .cornerRadius(30)
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
