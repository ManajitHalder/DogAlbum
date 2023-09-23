//
//  DogAllView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct DogAllView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.80)
            
            Text("Test View")
        }
    }
}

struct DogAllView_Previews: PreviewProvider {
    static var previews: some View {
        DogAllView()
    }
}
