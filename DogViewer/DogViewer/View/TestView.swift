//
//  TestView.swift
//  
//  Created by Manajit Halder on 12/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.gray
                .edgesIgnoringSafeArea(.all)
            
            Text("Test View")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
