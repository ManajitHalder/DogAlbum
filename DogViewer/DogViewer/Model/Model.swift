//
//  Model.swift
//  
//  Created by Manajit Halder on 24/08/23 using Swift 5.0 on MacOS 13.4
//  

import Foundation

struct Dog: Codable {
    let message: String
    let status: String
}

struct BreedList: Codable {
    let message: [String: [String]]
    let status: String
}
