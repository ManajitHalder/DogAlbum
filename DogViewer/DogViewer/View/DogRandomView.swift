//
//  DogRandomView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogRandomView: View {
    @StateObject private var dogViewModel = DogVM()
    @State private var isOverlayActive = false
    
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
                .opacity(0.45)
            
            VStack {
                NavigationView {
                    ZStack {
                        Color.gray
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.45)
                        
                        VStack {
                            Text(dogViewModel.dogBreed)
                                .padding()
                                .frame(maxWidth: 450)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundColor(Color.black)
                                .border(.black, width: 2.5)
                                .cornerRadius(7)
                            
                            ZStack {
                                Image(uiImage: dogViewModel.dogImage)
                                    .resizable()
                                    .frame(maxWidth: 500, maxHeight: 600, alignment: .bottom)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.black.opacity(0.5), lineWidth: 2)
                                    )
//                                    .overlay(
//                                        HStack {
//                                            Spacer()
//
//                                            Button {
//                                                dogViewModel.fetchRandomDog()
//                                            } label: {
//                                                Image(systemName: "arrowshape.turn.up.right.circle")
//                                                    .resizable()
//                                                    .frame(width: 40, height: 40)
//                                                    .foregroundColor(Color.black.opacity(0.25))
//                                            }
//                                        }
//                                    )
                                
                                if isOverlayActive {
                                    Color.red.opacity(0.5) // Overlay color with opacity
                                        .onTapGesture {
                                            // Action to perform when the overlay is tapped on the right side
                                            print("Overlay Tapped")
                                            dogViewModel.fetchRandomDog()
                                            isOverlayActive = false
                                        }
                                        .edgesIgnoringSafeArea(.all)
                                }
                            }
//                            Button {
//                                dogViewModel.fetchRandomDog()
//                            } label: {
//                                Image(systemName: "arrowshape.turn.up.right.circle")
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                                    .foregroundColor(Color.black)
//                            }
                            .gesture(
                                        DragGesture(minimumDistance: 0)
                                            .onChanged { value in
                                                if value.location.x >= UIScreen.main.bounds.width / 2 {
                                                    isOverlayActive = true
                                                }
                                            }
                            )
                        }
                        .padding(.bottom, 10)
                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .principal) {
////                                HStack {
////                                    Spacer()
////                                    Text("Dogs")
////                                        .font(.system(size: 35, weight: .bold, design: .serif))
////                                    Spacer()
////                                }
//                            }
//                        }
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
