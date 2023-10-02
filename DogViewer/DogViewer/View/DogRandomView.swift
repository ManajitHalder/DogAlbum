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
                
                VStack {
                    Image(uiImage: dogViewModel.dogDetail.image)
                        .resizable()
                        .frame(maxWidth: 500, maxHeight: 650, alignment: .bottom)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 2)
                        )
                        .overlay(
                            HStack {
                                Spacer()

                                Button {
                                    dogViewModel.fetchRandomDog()
                                } label: {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.trailing, 5)
                                        .foregroundColor(Color.accentColor.opacity(0.50))
                                }
                            }
                        )
                }
                
                HStack {
                    Text(dogViewModel.dogDetail.breed)
                        .padding()
                        .font(.custom("Cochin", size: 30))
                        .lineLimit(1)
                        .fontDesign(.rounded)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 400, maxHeight: 50)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.accentColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black.opacity(0.5), lineWidth: 2)
                        )
                    
                    Button {
                        dogViewModel.fetchRandomDog()
                    } label: {
                        Image(systemName: "arrow.right")
                            .frame(maxWidth: 50, maxHeight: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 2)
                            )
                            .foregroundColor(Color.black)
                    }
                }
                .frame(maxHeight: 50)
                .padding(.top, 7)

            }
            .padding(.bottom, 5)
            .padding([.leading, .trailing])
            
            .onAppear {
                dogViewModel.fetchRandomDog()
            }
        }
    }
}

struct DogRandomView_Previews: PreviewProvider {
    static var previews: some View {
        DogRandomView()
    }
}
