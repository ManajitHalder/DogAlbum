//
//  DogViewerApp.swift
//  
//  Created by Manajit Halder on 11/08/23 using Swift 5.0 on MacOS 13.4
//  

import SwiftUI

@main
struct DogViewerApp: App {
//    @StateObject private var dogViewModel = DogVM()
    
    var body: some Scene {
        WindowGroup {
            DogMainView()
//                .environmentObject(dogViewModel)
        }
    }
}
